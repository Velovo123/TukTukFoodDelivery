//
//  CartManager.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

@Observable
final class CartManager {
    
    var itemsByRestaurant: [UUID: [CartItem]] = [:]
    var restaurantNames: [UUID: String] = [:]
    var restaurantEmojis: [UUID: String] = [:]
    
    var isEmpty: Bool { itemsByRestaurant.isEmpty }
    
    var itemCount: Int {
        itemsByRestaurant.values.flatMap { $0 }.reduce(0) { $0 + $1.quantity }
    }
    
    var totalAmount: Double {
        itemsByRestaurant.values.flatMap { $0 }.reduce(0) { $0 + $1.total }
    }
    
    var allItems: [CartItem] {
        itemsByRestaurant.values.flatMap { $0 }
    }
    
    func add(_ menuItem: MenuItem, from restaurant: Restaurant) {
        let id = restaurant.id
        restaurantNames[id] = restaurant.name
        restaurantEmojis[id] = restaurant.category.emoji
        
        if itemsByRestaurant[id] == nil {
            itemsByRestaurant[id] = []
        }
        
        if let index = itemsByRestaurant[id]?.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            itemsByRestaurant[id]?[index].quantity += 1
        } else {
            itemsByRestaurant[id]?.append(CartItem(
                id: UUID(),
                restaurantId: id,
                menuItem: menuItem,
                quantity: 1
            ))
        }
    }
    
    func increment(_ menuItem: MenuItem, in restaurantId: UUID) {
        guard let index = itemsByRestaurant[restaurantId]?.firstIndex(where: {
            $0.menuItem.id == menuItem.id
        }) else { return }
        itemsByRestaurant[restaurantId]?[index].quantity += 1
    }
    
    func remove(_ menuItem: MenuItem, from restaurantId: UUID) {
        guard let index = itemsByRestaurant[restaurantId]?.firstIndex(where: {
            $0.menuItem.id == menuItem.id
        }) else { return }
        
        if itemsByRestaurant[restaurantId]?[index].quantity ?? 0 > 1 {
            itemsByRestaurant[restaurantId]?[index].quantity -= 1
        } else {
            itemsByRestaurant[restaurantId]?.remove(at: index)
            if itemsByRestaurant[restaurantId]?.isEmpty == true {
                itemsByRestaurant.removeValue(forKey: restaurantId)
                restaurantNames.removeValue(forKey: restaurantId)
                restaurantEmojis.removeValue(forKey: restaurantId)
            }
        }
    }
    
    func quantity(of menuItem: MenuItem, in restaurantId: UUID) -> Int {
        itemsByRestaurant[restaurantId]?.first {
            $0.menuItem.id == menuItem.id
        }?.quantity ?? 0
    }
    
    func total(for restaurantId: UUID) -> Double {
        itemsByRestaurant[restaurantId]?.reduce(0) { $0 + $1.total } ?? 0
    }
    
    func clearRestaurant(_ restaurantId: UUID) {
        itemsByRestaurant.removeValue(forKey: restaurantId)
        restaurantNames.removeValue(forKey: restaurantId)
        restaurantEmojis.removeValue(forKey: restaurantId)
    }
    
    func clear() {
        itemsByRestaurant = [:]
        restaurantNames = [:]
        restaurantEmojis = [:]
    }
}
