//
//  FeatureRestaurantCard.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

struct FeaturedRestaurantCard: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            ZStack(alignment: .topLeading) {
                
                RoundedRectangle(cornerRadius: Radius.lg)
                    .fill(Color.appGreenTint)
                    .frame(height: 160)
                
                
                Text(restaurant.category.emoji)
                    .font(.system(size: 72))
                    .opacity(0.4)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 160)
                
                
                Text(L10n.Food.new)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xs)
                    .background(Color.appGreen)
                    .clipShape(RoundedRectangle(cornerRadius: Radius.sm))
                    .padding(Spacing.sm)
            }
            
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(restaurant.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.textTetriary)
                    
                    Text(restaurant.hours)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.textSecondary)
                    
                    Spacer()
                    
                    
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.warning)
                        
                        Text(String(format: "%.1f", restaurant.rating))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color.textPrimary)
                    }
                }
            }
            .padding(Spacing.md)
        }
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.07), radius: 12, y: 4)
    }
}

#Preview {
    FeaturedRestaurantCard(restaurant: .preview)
        .padding()
}
