//
//  CategoryChip.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct CategoryChip: View {
    
    let category: FoodCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.xs) {
                Text(category.emoji)
                    .font(.system(size: 14))
                Text(category.title)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? Color.white : Color.textPrimary)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(
                RoundedRectangle(cornerRadius: Radius.full)
                    .fill(isSelected ? Color.appGreen : Color.bgPrimary)
                    .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Radius.full)
                    .stroke(isSelected ? Color.clear : Color.separator, lineWidth: 1)
            )
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
