//
//  Shimmer.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

// MARK: - Shimmer effect
struct ShimmerEffect: ViewModifier {
    
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    LinearGradient(
                        stops: [
                            .init(color: .clear,              location: 0),
                            .init(color: .white.opacity(0.5), location: 0.3),
                            .init(color: .clear,              location: 0.6)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 3)
                    .offset(x: isAnimating ? geo.size.width * 2 : -geo.size.width * 2)
                    .animation(
                        .linear(duration: 1.2)
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                }
                .clipped()
            }
            .onAppear {
                isAnimating = true
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerEffect())
    }
}

struct SkeletonRow: View {
    var height: CGFloat
    var cornerRadius: CGFloat = 4
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.separator)
            .frame(maxWidth: .infinity)  
            .frame(height: height)
            .shimmer()
    }
}
