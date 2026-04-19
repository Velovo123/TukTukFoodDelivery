//
//  PreviewData.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import Foundation

extension Restaurant {
    static let preview = Restaurant(
        id: UUID(),
        name: "Home Taste",
        category: .cafe,
        hours: "Mon–Sat · 11:00–19:00",
        isNew: true,
        rating: 4.8
    )

    static let previews: [Restaurant] = [
        preview,
        Restaurant(id: UUID(), name: "Shawarma House", category: .shawarma,
                   hours: "Mon–Sun · 10:00–23:00", isNew: true,  rating: 4.6),
        Restaurant(id: UUID(), name: "Pizza Bella",    category: .pizza,
                   hours: "Mon–Sun · 11:00–22:30", isNew: false, rating: 4.5),
        Restaurant(id: UUID(), name: "Cafe Breeze",    category: .cafe,
                   hours: "Mon–Sun · 08:00–22:00", isNew: false, rating: 4.7),
        Restaurant(id: UUID(), name: "Sushi Master",   category: .sushi,
                   hours: "Mon–Sun · 11:00–21:00", isNew: false, rating: 4.6),
        Restaurant(id: UUID(), name: "Burger Club",    category: .burgers,
                   hours: "Mon–Sun · 11:00–23:00", isNew: false, rating: 4.4)
    ]
}

extension Cart {
    static let preview: Cart = {
        var cart = Cart()
        cart.add(MenuItem.previews[0], from: Restaurant.preview.id)
        cart.add(MenuItem.previews[1], from: Restaurant.preview.id)
        return cart
    }()
}

extension MenuItem {
    static let previews: [MenuItem] = [
        MenuItem(id: UUID(), name: "Caesar Salad",
                 description: "Romaine lettuce, croutons, parmesan",
                 price: 89, category: "Salads", emoji: "🥗"),
        MenuItem(id: UUID(), name: "Chicken Soup",
                 description: "Homemade broth with vegetables",
                 price: 65, category: "Soups", emoji: "🍲"),
        MenuItem(id: UUID(), name: "Grilled Chicken",
                 description: "With seasonal vegetables and sauce",
                 price: 145, category: "Main", emoji: "🍗"),
        MenuItem(id: UUID(), name: "Cheesecake",
                 description: "Classic New York style",
                 price: 75, category: "Desserts", emoji: "🍰"),
        MenuItem(id: UUID(), name: "Latte",
                 description: "Double shot espresso with steamed milk",
                 price: 55, category: "Drinks", emoji: "☕"),
        MenuItem(id: UUID(), name: "Fresh Juice",
                 description: "Orange, apple or carrot",
                 price: 45, category: "Drinks", emoji: "🥤")
    ]
}

extension TaxiOrder {
    static let preview = TaxiOrder(
        id: UUID(),
        pickupAddress: "Shevchenka St, 12",
        destinationAddress: "Franka St, 5",
        scheduledDate: .now,
        isNow: true,
        comment: "",
        paymentMethod: .card,
        status: .pending
    )

    static let previews: [TaxiOrder] = [
        preview,
        TaxiOrder(id: UUID(),
                  pickupAddress: "Zolochiv Castle",
                  destinationAddress: "Bus Station",
                  scheduledDate: .now,
                  isNow: false,
                  comment: "Please call on arrival",
                  paymentMethod: .cash,
                  status: .completed),
        TaxiOrder(id: UUID(),
                  pickupAddress: "Market Square",
                  destinationAddress: "Hospital",
                  scheduledDate: .now,
                  isNow: false,
                  comment: "",
                  paymentMethod: .card,
                  status: .completed)
    ]
}

extension User {
    static let preview = User(
        id: UUID(),
        name: "Oleksiy",
        phone: "+380 96 123 4567",
        email: "oleksiy@example.com",
        bonusBalance: 60,
        savedAddresses: SavedAddress.previews,
        notificationsEnabled: true
    )
}

extension SavedAddress {
    static let previews: [SavedAddress] = [
        SavedAddress(id: UUID(), label: "Home",  address: "Shevchenka St, 12, Zolochiv"),
        SavedAddress(id: UUID(), label: "Work",  address: "Franka St, 5, Zolochiv")
    ]
}
