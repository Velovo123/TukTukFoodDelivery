//
//  MenuItemRow.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

struct MenuItemRow: View {
    
    let item: MenuItem
    let quantity: Int
    let onAdd: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            
            // Info
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(item.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                Text(item.description)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
                    .lineLimit(2)
                
                Text(item.formattedPrice)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.appGreen)
            }
            
            Spacer()
            
            VStack(spacing: Spacing.xs) {
                RoundedRectangle(cornerRadius: Radius.sm)
                    .fill(Color.appGreenTint)
                    .frame(width: 72, height: 72)
                    .overlay {
                        Text(item.emoji)
                            .font(.system(size: 32))
                    }
                
                if quantity > 0 {
                    HStack(spacing: Spacing.xs) {
                        Button { onRemove() } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 22, height: 22)
                                .background(Color.appGreen)
                                .clipShape(Circle())
                        }
                        
                        Text("\(quantity)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(Color.textPrimary)
                            .frame(minWidth: 16)
                        
                        Button { onAdd() } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 22, height: 22)
                                .background(Color.appGreen)
                                .clipShape(Circle())
                        }
                    }
                } else {
                    Button { onAdd() } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 26, height: 26)
                            .background(Color.appGreen)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
        .animation(.spring(response: 0.3), value: quantity)
    }
}
