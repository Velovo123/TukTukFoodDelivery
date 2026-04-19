//
//  User.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import Foundation

struct User: Identifiable {
    let id: UUID
    var name: String
    var phone: String
    var email: String?
    var bonusBalance: Double
    var savedAddresses: [SavedAddress]
    var notificationsEnabled: Bool
}

struct SavedAddress: Identifiable {
    let id: UUID
    var label: String
    var address: String

    var icon: String {
        switch label.lowercased() {
        case "home": return "house"
        case "work": return "briefcase"
        default:     return "mappin"
        }
    }
}
