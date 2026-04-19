
import Foundation

struct CartItem: Identifiable {
    let id: UUID
    let restaurantId: UUID
    let menuItem: MenuItem
    var quantity: Int

    var total: Double {
        menuItem.price * Double(quantity)
    }
}


struct Cart {
    var items: [CartItem] = []
    var restaurantId: UUID?

    var isEmpty: Bool { items.isEmpty }

    var totalAmount: Double {
        items.reduce(0) { $0 + $1.total }
    }

    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    mutating func add(_ menuItem: MenuItem, from restaurantId: UUID) {
        if self.restaurantId != restaurantId {
            items = []
            self.restaurantId = restaurantId
        }

        if let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(
                id: UUID(),
                restaurantId: restaurantId,
                menuItem: menuItem,
                quantity: 1
            ))
        }
    }

    mutating func remove(_ menuItem: MenuItem) {
        guard let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id }) else { return }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    mutating func clear() {
        items = []
        restaurantId = nil
    }
}
