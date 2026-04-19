//
//  ProfileMenuRow.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct ProfileMenuRow: View {
    
    let icon: String
    let title: String
    let subtitle: String
    var showToggle: Bool = false
    var toggleValue: Binding<Bool> = .constant(false)
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: Radius.xs)
                    .fill(Color.appGreenTint)
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appGreen)
            }
            
            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
            }
            
            Spacer()
            
            // Trailing
            if showToggle {
                Toggle("", isOn: toggleValue)
                    .labelsHidden()
                    .tint(Color.appGreen)
            } else {
                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textTetriary)
            }
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
    }
}

#Preview {
    VStack {
        ProfileMenuRow(
            icon: "doc.text",
            title: "My orders",
            subtitle: "History & status"
        )
        ProfileMenuRow(
            icon: "bell",
            title: "Notifications",
            subtitle: "Enabled",
            showToggle: true,
            toggleValue: .constant(true)
        )
    }
    .padding()
}
