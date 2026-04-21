//
//  LoginView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

struct LoginView: View {
    
    let onSignIn: (String) async -> Void
    
    @State private var phone = ""
    @State private var isLoading = false
    
    var isValid: Bool {
        phone.count >= 10
    }
    
    var body: some View {
        VStack(spacing: Spacing.xl) {
            Spacer()
            
            logoSection
            
            Spacer()
            
            phoneSection
            ctaButton
            
            Spacer()
        }
        .padding(.horizontal, Spacing.md)
        .background(Color.bgSurface)
        .scrollDismissesKeyboard(.immediately)
    }
}


private extension LoginView {
    
    var logoSection: some View {
        VStack(spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.lg)
                    .fill(Color.appGreen)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color.appGreen.opacity(0.4), radius: 16, y: 6)
                
                Image(systemName: "car.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }
            
            Text("Тук-Тук")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            
            Text(L10n.Auth.signInTitle)
                .font(.system(size: 15))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
}


private extension LoginView {
    
    var phoneSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(L10n.Auth.phoneLabel)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.textSecondary)
            
            HStack(spacing: Spacing.sm) {
                Text("🇺🇦")
                    .font(.system(size: 20))
                
                TextField(L10n.Auth.phonePlaceholder, text: $phone)
                    .keyboardType(.phonePad)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.textPrimary)
            }
            .padding(Spacing.md)
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.md)
                    .stroke(
                        phone.isEmpty ? Color.separator : Color.appGreen,
                        lineWidth: 1.5
                    )
            )
            .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
            .animation(.easeOut(duration: 0.2), value: phone.isEmpty)
        }
    }
}


private extension LoginView {
    
    var ctaButton: some View {
        Button {
            Task {
                isLoading = true
                await onSignIn(phone)
                isLoading = false
            }
        } label: {
            HStack(spacing: Spacing.sm) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
                
                Text(L10n.Auth.continueButton)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .background(isValid ? Color.appGreen : Color.separator)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .animation(.easeOut, value: isValid)
        }
        .disabled(!isValid || isLoading)
        .padding(.top, Spacing.xs)
    }
}

#Preview {
    LoginView { _ in }
}
