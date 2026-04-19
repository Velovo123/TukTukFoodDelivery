//
//  CartView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

struct CartView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appContainer) private var container
    @State private var isOrdering = false
    @State private var orderPlaced = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if orderPlaced {
                    orderSuccessView
                } else if container.cart.isEmpty {
                    emptyCartView
                } else {
                    cartContentView
                }
            }
            .background(Color.bgSurface)
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.textTetriary)
                            .font(.system(size: 22))
                    }
                }
            }
        }
    }
}

private extension CartView {
    
    var cartContentView: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.lg) {
                    ForEach(Array(container.cart.itemsByRestaurant.keys), id: \.self) { restaurantId in
                        if let items = container.cart.itemsByRestaurant[restaurantId] {
                            restaurantSection(
                                restaurantId: restaurantId,
                                items: items
                            )
                        }
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.md)
                .padding(.bottom, 120)
            }
            .background(Color.bgSurface)
            
            orderButton
        }
    }
    
    func restaurantSection(restaurantId: UUID, items: [CartItem]) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            
            HStack(spacing: Spacing.sm) {
                Text(container.cart.restaurantEmojis[restaurantId] ?? "🍽")
                    .font(.system(size: 20))
                
                Text(container.cart.restaurantNames[restaurantId] ?? "Restaurant")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                
                Spacer()
                
                Button {
                    container.cart.clearRestaurant(restaurantId)
                } label: {
                    Text("Clear")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.destructive)
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            
            VStack(spacing: Spacing.xs) {
                ForEach(items) { item in
                    cartItemRow(item, restaurantId: restaurantId)
                }
            }
            
            HStack {
                Text("Subtotal")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textSecondary)
                Spacer()
                Text(String(format: "%.0f ₴", container.cart.total(for: restaurantId)))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
            }
            .padding(.horizontal, Spacing.sm)
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
    }
    
    func cartItemRow(_ item: CartItem, restaurantId: UUID) -> some View {
        HStack(spacing: Spacing.md) {
            RoundedRectangle(cornerRadius: Radius.sm)
                .fill(Color.appGreenTint)
                .frame(width: 44, height: 44)
                .overlay {
                    Text(item.menuItem.emoji)
                        .font(.system(size: 20))
                }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(item.menuItem.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                Text(item.menuItem.formattedPrice)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
            }
            
            Spacer()
            
            HStack(spacing: Spacing.sm) {
                Button {
                    container.cart.remove(item.menuItem, from: restaurantId)
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.appGreen)
                        .clipShape(Circle())
                }
                
                Text("\(item.quantity)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                    .frame(minWidth: 20)
                
                Button {
                    container.cart.increment(item.menuItem, in: restaurantId)
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.appGreen)
                        .clipShape(Circle())
                }
            }
            
            // Total
            Text(String(format: "%.0f ₴", item.total))
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color.textPrimary)
                .frame(minWidth: 44, alignment: .trailing)
        }
        .padding(.vertical, Spacing.xs)
    }
    
    var orderButton: some View {
        VStack(spacing: Spacing.sm) {
            HStack {
                Text("Total")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                Spacer()
                Text(String(format: "%.0f ₴", container.cart.totalAmount))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.appGreen)
            }
            
            Button {
                Task { await placeOrder() }
            } label: {
                HStack(spacing: Spacing.sm) {
                    if isOrdering {
                        ProgressView().tint(.white)
                    }
                    Text("Place order")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(Color.appGreen)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            }
            .disabled(isOrdering)
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.md)
    }
    
    func placeOrder() async {
        isOrdering = true
        try? await Task.sleep(for: .seconds(1.5))
        container.cart.clear()
        withAnimation(.spring()) {
            orderPlaced = true
        }
        isOrdering = false
    }
}

private extension CartView {
    
    var emptyCartView: some View {
        VStack(spacing: Spacing.md) {
            Spacer()
            Text("🛒")
                .font(.system(size: 56))
            Text("Cart is empty")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            Text("Add items from restaurants to get started")
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.horizontal, Spacing.md)
    }
}

private extension CartView {
    
    var orderSuccessView: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.appGreenTint)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundStyle(Color.appGreen)
            }
            
            VStack(spacing: Spacing.sm) {
                Text("Order placed!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                
                Text("Your order has been received.\nWe'll notify you when it's ready.")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.md)
                    .background(Color.appGreen)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            }
            .padding(.horizontal, Spacing.md)
            .padding(.bottom, Spacing.xl)
        }
    }
}

#Preview {
    CartView()
}
