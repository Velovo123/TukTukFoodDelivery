//
//  CartButton.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//


import SwiftUI

struct CartButton: View {
    
    let itemCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "basket")
                    .font(.system(size: 22))
                    .foregroundStyle(Color.textPrimary)
                    .frame(width: 44, height: 44)
                    .background(Color.bgPrimary)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.08), radius: 6, y: 2)
                
                if itemCount > 0 {
                    ZStack {
                        Circle()
                            .fill(Color.appGreen)
                            .frame(width: 18, height: 18)
                        
                        Text("\(itemCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .offset(x: 4, y: -4)
                }
            }
        }
        .animation(.spring(response: 0.3), value: itemCount)
    }
}

#Preview {
    HStack {
        CartButton(itemCount: 0) {}
        CartButton(itemCount: 3) {}
    }
    .padding()
}
