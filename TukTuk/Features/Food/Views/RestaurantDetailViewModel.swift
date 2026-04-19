//
//  RestaurantDetailViewModel.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

@Observable
final class RestaurantDetailViewModel {
    
    var isLoading = false
    var menuItems: [MenuItem] = []
    var errorMessage: String?
    
    func loadMenu(for restaurant: Restaurant) async {
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(1))
        menuItems = MenuItem.previews
    }
}
