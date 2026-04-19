//
//  TaxiOrder.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import Foundation

struct TaxiOrder: Identifiable {
    let id: UUID
    var pickupAddress: String
    var destinationAddress: String
    var scheduledDate: Date
    var isNow: Bool
    var comment: String
    var paymentMethod: PaymentMethod
    var status: OrderStatus

    init(
        id: UUID = UUID(),
        pickupAddress: String = "",
        destinationAddress: String = "",
        scheduledDate: Date = .now,
        isNow: Bool = true,
        comment: String = "",
        paymentMethod: PaymentMethod = .card,
        status: OrderStatus = .pending
    ) {
        self.id = id
        self.pickupAddress = pickupAddress
        self.destinationAddress = destinationAddress
        self.scheduledDate = scheduledDate
        self.isNow = isNow
        self.comment = comment
        self.paymentMethod = paymentMethod
        self.status = status
    }
}

enum PaymentMethod: CaseIterable {
    case card
    case cash

    var displayName: String {
        switch self {
        case .card: return L10n.Taxi.paymentCard
        case .cash: return L10n.Taxi.paymentCash
        }
    }

    var icon: String {
        switch self {
        case .card: return "creditcard"
        case .cash: return "banknote"
        }
    }
}

enum OrderStatus {
    case pending
    case active
    case completed
    case cancelled

    var displayName: String {
        switch self {
        case .pending:   return "Pending"
        case .active:    return "Active"
        case .completed: return "Completed"
        case .cancelled: return "Cancelled"
        }
    }

    var color: String {
        switch self {
        case .pending:   return "warning"
        case .active:    return "appGreen"
        case .completed: return "textSecondary"
        case .cancelled: return "destructive"
        }
    }
}
