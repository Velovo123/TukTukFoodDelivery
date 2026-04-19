//
//  RestaurantCard.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import SwiftUI

struct RestaurantCard: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            
            
            RoundedRectangle(cornerRadius: Radius.md)
                .fill(Color.appGreenTint)
                .frame(width: 56, height: 56)
                .overlay {
                    Text(restaurant.category.emoji)
                        .font(.system(size: 26))
                }
            
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(restaurant.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.textTetriary)
                    
                    Text(restaurant.hours)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.textSecondary)
                }
            }
            
            Spacer()
            
            
            VStack(alignment: .trailing, spacing: Spacing.xs) {
                if restaurant.isNew {
                    Text(L10n.Food.new)
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(Color.appGreen)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(Color.appGreenTint)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                }
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textTetriary)
            }
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
    }
}

#Preview {
    RestaurantCard(restaurant: .preview)
        .padding()
}
