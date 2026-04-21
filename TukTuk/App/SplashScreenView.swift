//
//  SplashScreenView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

struct SplashView: View {
    
    @State private var iconScale: CGFloat = 0.7
    @State private var iconOpacity: CGFloat = 0
    @State private var contentOpacity: CGFloat = 0
    @State private var headerOffset: CGFloat = -20
    
    var body: some View {
        ZStack {
            Color.bgSurface.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Green header
                ZStack(alignment: .bottom) {
                    LinearGradient(
                        colors: [Color.appGreen, Color.appGreenDark],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea(edges: .top)
                    
                    // App icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(.white)
                            .frame(width: 100, height: 100)
                            .shadow(
                                color: Color.appGreen.opacity(0.4),
                                radius: 24, y: 12
                            )
                        
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.appGreen)
                            .frame(width: 72, height: 72)
                        
                        Image(systemName: "car.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(iconScale)
                    .opacity(iconOpacity)
                    .offset(y: 50)
                }
                .frame(height: 300)
                .offset(y: headerOffset)
                
                Spacer()
                
                VStack(spacing: Spacing.xs) {
                    Text("Тук-Тук")
                        .font(.system(size: 38, weight: .black))
                        .foregroundStyle(Color.textPrimary)
                        .kerning(-1)
                    
                    Text(L10n.Splash.tagline)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.textSecondary)
                }
                .opacity(contentOpacity)
                .padding(.top, 60)
                
                Spacer()
                
                ProgressView()
                    .tint(Color.appGreen)
                    .opacity(contentOpacity)
                    .padding(.bottom, Spacing.xxl)
            }
        }
        .onAppear {
            animate()
        }
    }
    
    private func animate() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            headerOffset = 0
        }
        
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.2)) {
            iconScale = 1
            iconOpacity = 1
        }
        
        withAnimation(.easeOut(duration: 0.4).delay(0.5)) {
            contentOpacity = 1
        }
    }
}

#Preview {
    SplashView()
}
