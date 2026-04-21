//
//  OrdersViewModel.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

@Observable
final class OrdersViewModel {
    
    var orders: [TaxiOrder] = []
    var selectedSegment: OrderSegment = .active
    var isLoading = false
    var errorMessage: String?
    
    var activeOrders: [TaxiOrder] {
        orders.filter { $0.status == .active || $0.status == .pending }
    }
    
    var historyOrders: [TaxiOrder] {
        orders.filter { $0.status == .completed || $0.status == .cancelled }
    }
    
    var currentOrders: [TaxiOrder] {
        selectedSegment == .active ? activeOrders : historyOrders
    }
    
    func loadOrders() async {
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(0.5))
        
        //TODO: Replace with real API
        orders = TaxiOrder.previews
    }
}

enum OrderSegment: CaseIterable {
    case active
    case history
    
    var title: String {
        switch self {
        case .active:  return "Active"
        case .history: return "History"
        }
    }
}
