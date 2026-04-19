//
//  OrderRow.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct OrderRow: View {
    
    let order: TaxiOrder
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            
            // Status + date
            HStack {
                StatusBadge(status: order.status)
                
                Spacer()
                
                Text(order.scheduledDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textTetriary)
            }
            
            Divider()
            
            // Route
            VStack(alignment: .leading, spacing: Spacing.xs) {
                routeRow(
                    icon: "circle.fill",
                    color: .appGreen,
                    text: order.pickupAddress
                )
                
                routeRow(
                    icon: "mappin.circle.fill",
                    color: .destructive,
                    text: order.destinationAddress
                )
            }
            
            // Payment
            HStack(spacing: Spacing.xs) {
                Image(systemName: order.paymentMethod.icon)
                    .font(.system(size: 11))
                    .foregroundStyle(Color.textTetriary)
                
                Text(order.paymentMethod.displayName)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
            }
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
    }
    
    func routeRow(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(color)
                .frame(width: 16)
            
            Text(text.isEmpty ? "—" : text)
                .font(.system(size: 14))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
        }
    }
}

// MARK: - Status Badge
struct StatusBadge: View {
    
    let status: OrderStatus
    
    var body: some View {
        Text(status.displayName)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
    
    private var foregroundColor: Color {
        switch status {
        case .pending:   return Color.warning
        case .active:    return Color.appGreen
        case .completed: return Color.textSecondary
        case .cancelled: return Color.destructive
        }
    }
    
    private var backgroundColor: Color {
        switch status {
        case .pending:   return Color.warning.opacity(0.15)
        case .active:    return Color.appGreen.opacity(0.15)
        case .completed: return Color.separator
        case .cancelled: return Color.destructive.opacity(0.15)
        }
    }
}

#Preview {
    OrderRow(order: .preview)
        .padding()
}
