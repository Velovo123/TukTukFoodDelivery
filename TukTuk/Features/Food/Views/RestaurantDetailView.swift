//
//  RestaurantDetailView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    let restaurant: Restaurant
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appContainer) private var container
    @State private var viewModel = RestaurantDetailViewModel()
    @State private var showCart = false
    
    var body: some View {
        VStack(spacing: 0) {
            headerImage
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    infoSection
                    divider
                    menuSection
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, 120)
            }
            .background(Color.bgSurface)
        }
        .background(Color.bgSurface)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .overlay(alignment: .top) {
            HStack {
                Spacer()
                CartButton(itemCount: container.cart.itemCount) {
                    showCart = true
                }
                .padding(.trailing, Spacing.md)
                .padding(.top, 56)
            }
        }
        .overlay(alignment: .bottom) {
            orderButton
        }
        .ignoresSafeArea(edges: .top)
        .task {
            await viewModel.loadMenu(for: restaurant)
        }
        .sheet(isPresented: $showCart) {
            CartView()
        }
    }
}


private extension RestaurantDetailView {
    
    var backButton: some View {
        Button { dismiss() } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

private extension RestaurantDetailView {
    
    var headerImage: some View {
        ZStack {
            Color.appGreenTint
            Text(restaurant.category.emoji)
                .font(.system(size: 120))
                .opacity(0.5)
        }
        .frame(height: 280)
    }
}

private extension RestaurantDetailView {
    
    var infoSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(alignment: .top) {
                Text(restaurant.name)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                if restaurant.isNew {
                    Text(L10n.Food.new)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, Spacing.xs)
                        .background(Color.appGreen)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                }
            }
            
            HStack(spacing: Spacing.xs) {
                Image(systemName: "star.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.warning)
                
                Text(String(format: "%.1f", restaurant.rating))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                Text("·")
                    .foregroundStyle(Color.textTetriary)
                
                Image(systemName: "clock")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textTetriary)
                
                Text(restaurant.hours)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.textSecondary)
            }
        }
        .padding(.top, Spacing.md)
    }
    
    var divider: some View {
        Rectangle()
            .fill(Color.separator)
            .frame(height: 1)
    }
}

private extension RestaurantDetailView {
    
    var menuSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Menu")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            
            if viewModel.isLoading {
                ForEach(0..<4, id: \.self) { _ in
                    menuItemPlaceholder
                }
            } else if let error = viewModel.errorMessage {
                errorState(error)
            } else {
                ForEach(viewModel.menuItems) { item in
                    MenuItemRow(
                        item: item,
                        quantity: container.cart.quantity(of: item, in: restaurant.id),
                        onAdd: { container.cart.add(item, from: restaurant) },
                        onRemove: { container.cart.remove(item, from: restaurant.id) }
                    )
                }
            }
        }
    }
    
    func errorState(_ message: String) -> some View {
        VStack(spacing: Spacing.sm) {
            Text("⚠️").font(.system(size: 40))
            Text(message)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
            Button(L10n.Error.tryAgain) {
                Task { await viewModel.loadMenu(for: restaurant) }
            }
            .foregroundStyle(Color.appGreen)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.xl)
    }
    
    var menuItemPlaceholder: some View {
        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                RoundedRectangle(cornerRadius: 4).fill(Color.separator)
                    .frame(width: 140, height: 14).shimmer()
                RoundedRectangle(cornerRadius: 4).fill(Color.separator)
                    .frame(width: 90, height: 12).shimmer()
                RoundedRectangle(cornerRadius: 4).fill(Color.separator)
                    .frame(width: 60, height: 14).shimmer()
            }
            Spacer()
            RoundedRectangle(cornerRadius: Radius.md)
                .fill(Color.separator)
                .frame(width: 72, height: 72).shimmer()
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
    }
}

private extension RestaurantDetailView {
    
    var orderButton: some View {
        Button {
            showCart = true
        } label: {
            HStack {
                Text("View cart")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                
                if container.cart.totalAmount > 0 {
                    Spacer()
                    Text(String(format: "%.0f ₴", container.cart.totalAmount))
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.lg)
            .background(container.cart.isEmpty ? Color.separator : Color.appGreen)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .animation(.easeOut, value: container.cart.isEmpty)
        }
        .disabled(container.cart.isEmpty)
        .padding(.horizontal, Spacing.md)
        .padding(.bottom, Spacing.md)
        .background(.clear)
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(restaurant: .preview)
    }
}
