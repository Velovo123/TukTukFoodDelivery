//
//  FoodViewModel.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import SwiftUI

@Observable
final class FoodViewModel {
    
    var restaurants: [Restaurant] = []
    var selectedCategory: FoodCategory = .all
    var isLoading = false
    var errorMessage: String?
    
    var filteredRestaurants: [Restaurant] {
        guard selectedCategory != .all else {
            return restaurants
        }
        return restaurants.filter { $0.category == selectedCategory }
    }
    
    var featuredRestaurant: Restaurant? {
        filteredRestaurants.first(where: { $0.isNew })
    }
    
    var regularRestaurants: [Restaurant] {
        guard let featured = featuredRestaurant else {
            return filteredRestaurants
        }
        return filteredRestaurants.filter { $0.id != featured.id }
    }
    
    func loadRestaurants() async {
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(5))
        
        restaurants = Restaurant.previews
    }
    
    func refresh() async {
        await loadRestaurants()
    }
}
