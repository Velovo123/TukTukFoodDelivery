//
//  FoodView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct FoodView: View {
    @State private var viewModel = FoodViewModel()
    @Environment(\.appContainer) private var container
    @State private var showCart = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        greetingSection
                        categorySection
                        restaurantSection
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, Spacing.xl)
                }
                .background(Color.bgSurface)
                .refreshable {
                    await viewModel.refresh()
                }
            }
            .background(Color.bgSurface)
            .task {
                await viewModel.loadRestaurants()
            }
            .sheet(isPresented: $showCart, onDismiss: {
                showCart = false
            }) {
                CartView()
            }
        }
    }
}

// MARK: - Header
private extension FoodView {
    
    var headerView: some View {
        HStack {
            logoView
            Spacer()
            cartButton
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(Color.bgSurface)
    }
    
    var logoView: some View {
        HStack(spacing: Spacing.sm) {
            RoundedRectangle(cornerRadius: Radius.sm)
                .fill(Color.appGreen)
                .frame(width: 32, height: 32)
                .overlay {
                    Image(systemName: "car.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                }
            
            Text("Тук-Тук")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.textPrimary)
        }
    }
    
    var cartButton: some View {
        CartButton(itemCount: container.cart.itemCount) {
            if !container.cart.isEmpty {
                showCart = true
            }
        }
    }
}

// MARK: - Greeting
private extension FoodView {
    
    var greetingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(L10n.Food.greeting)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
            
            Text(L10n.Food.question)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.textPrimary)
        }
        .padding(.top, Spacing.sm)
    }
}

// MARK: - Categories
private extension FoodView {
    
    var categorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(FoodCategory.allCases, id: \.self) { category in
                    CategoryChip(
                        category: category,
                        isSelected: viewModel.selectedCategory == category
                    ) {
                        viewModel.selectedCategory = category
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

// MARK: - Restaurants
private extension FoodView {
    
    var restaurantSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            
            Text("\(L10n.Food.venues): \(viewModel.filteredRestaurants.count)")
                .font(.system(size: 13))
                .foregroundStyle(Color.textSecondary)
            
            if viewModel.isLoading {
                loadingState
            } else if let error = viewModel.errorMessage {
                errorState(error)
            } else if viewModel.filteredRestaurants.isEmpty {
                emptyState
            } else {
                if let featured = viewModel.featuredRestaurant {
                    NavigationLink(destination: RestaurantDetailView(restaurant: featured)) {
                        FeaturedRestaurantCard(restaurant: featured)
                    }
                    .buttonStyle(.plain)
                }
                
                ForEach(viewModel.regularRestaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        RestaurantCard(restaurant: restaurant)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    var loadingState: some View {
        VStack(spacing: Spacing.sm) {
            ForEach(0..<4, id: \.self) { _ in
                SkeletonRow(height: 80, cornerRadius: Radius.md)
            }
        }
    }
    
    func errorState(_ message: String) -> some View {
        VStack(spacing: Spacing.sm) {
            Text("⚠️")
                .font(.system(size: 40))
            
            Text(message)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
            
            Button(L10n.Error.tryAgain) {
                Task { await viewModel.refresh() }
            }
            .foregroundStyle(Color.appGreen)
            .font(.system(size: 14, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.xl)
    }
    
    var emptyState: some View {
        VStack(spacing: Spacing.md) {
            Text("🍽")
                .font(.system(size: 56))
            
            Text("No places found")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
            
            Text("Try selecting a different category")
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.xl)
    }
}

#Preview {
    FoodView()
}
