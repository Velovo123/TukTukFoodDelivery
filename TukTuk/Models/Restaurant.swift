//
//  Restaurant.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import Foundation

struct Restaurant: Identifiable {
    let id: UUID
    let name: String
    let category: FoodCategory
    let hours: String
    let isNew: Bool
    let rating: Double
}



struct MenuItem: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let category: String
    var emoji: String = "🍽"
    
    var formattedPrice: String {
        String(format: "%.0f ₴", price)
    }
}

enum FoodCategory: CaseIterable {
    case all
    case shawarma
    case pizza
    case sushi
    case burgers
    case cafe

    var title: String {
        switch self {
        case .all:      return L10n.Food.all
        case .shawarma: return L10n.Food.shawarma
        case .pizza:    return L10n.Food.pizza
        case .sushi:    return L10n.Food.sushi
        case .burgers:  return L10n.Food.burgers
        case .cafe:     return L10n.Food.cafe
        }
    }

    var emoji: String {
        switch self {
        case .all:      return "🍽"
        case .shawarma: return "🌯"
        case .pizza:    return "🍕"
        case .sushi:    return "🍣"
        case .burgers:  return "🍔"
        case .cafe:     return "☕"
        }
    }
}
