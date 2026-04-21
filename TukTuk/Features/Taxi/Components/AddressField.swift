//
//  AddressField.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct AddressField: View {
    
    let placeholder: String
    @Binding var text: String
    let iconName: String
    let iconColor: Color
    
    @State private var showSuggestions = false
    

    private var suggestions: [String] {
        guard text.count >= 2 else { return [] }
        return AddressSuggestions.mock.filter {
            $0.lowercased().contains(text.lowercased())
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: Spacing.md) {
                Image(systemName: iconName)
                    .font(.system(size: 12))
                    .foregroundStyle(iconColor)
                    .frame(width: 20)
                
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.textPrimary)
                    .frame(minHeight: 44)
                    .onChange(of: text) { _, _ in
                        showSuggestions = !suggestions.isEmpty
                    }
                
                if !text.isEmpty {
                    Button {
                        text = ""
                        showSuggestions = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.textTetriary)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, Spacing.md)
            
            if showSuggestions && !suggestions.isEmpty {
                Divider()
                    .padding(.horizontal, Spacing.md)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button {
                            text = suggestion
                            showSuggestions = false
                        } label: {
                            HStack(spacing: Spacing.sm) {
                                Image(systemName: "mappin")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.textTetriary)
                                    .frame(width: 20)
                                
                                Text(suggestion)
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.textPrimary)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                        }
                        
                        if suggestion != suggestions.last {
                            Divider()
                                .padding(.leading, 52)
                        }
                    }
                }
            }
        }
        .animation(.easeOut(duration: 0.2), value: showSuggestions)
        .transaction { $0.animation = nil }
    }
}
