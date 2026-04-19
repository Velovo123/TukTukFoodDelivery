//
//  TaxiView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI
import MapKit

struct TaxiView: View {
    
    @State private var viewModel = TaxiViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                mapSection
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        titleSection
                        routeSection
                        dateTimeSection
                        commentSection
                        paymentSection
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, 100)
                }
                .background(Color.bgSurface)
                .ignoresSafeArea(.keyboard)
                .scrollDismissesKeyboard(.immediately)
            }
            .background(Color.bgSurface)
            .navigationBarHidden(true)
            .ignoresSafeArea(edges: .top)
            .overlay(alignment: .bottom) {
                ctaButton
            }
        }
    }
}

// MARK: - Map
private extension TaxiView {
    
    var mapSection: some View {
        ZStack(alignment: .bottom) {
            Map(position: $viewModel.mapPosition) {
                Marker(L10n.Taxi.location, coordinate: viewModel.coordinate)
                    .tint(.appGreen)
            }
            .frame(height: 260)
            .disabled(true)
            .clipped()
            
            // Gradient fade into background
            LinearGradient(
                colors: [
                    Color.bgSurface.opacity(0),
                    Color.bgSurface.opacity(0.5),
                    Color.bgSurface
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 80)
        }
    }
}

// MARK: - Title
private extension TaxiView {
    
    var titleSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(L10n.Taxi.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            
            Text(L10n.Taxi.subtitle)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
        }
        .padding(.top, Spacing.md)
    }
}

// MARK: - Route
private extension TaxiView {
    
    var routeSection: some View {
        VStack(spacing: Spacing.sm) {
            AddressField(
                placeholder: L10n.Taxi.from,
                text: $viewModel.order.pickupAddress,
                iconName: "circle.fill",
                iconColor: .appGreen
            )
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
            
            AddressField(
                placeholder: L10n.Taxi.to,
                text: $viewModel.order.destinationAddress,
                iconName: "mappin.circle.fill",
                iconColor: .destructive
            )
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
        }
        .transaction { $0.animation = nil }
    }
}

// MARK: - Date & Time
private extension TaxiView {
    
    var dateTimeSection: some View {
        HStack(spacing: Spacing.sm) {
            
            // Date
            HStack(spacing: Spacing.sm) {
                Image(systemName: "calendar")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.appGreen)
                
                DatePicker(
                    "",
                    selection: $viewModel.order.scheduledDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(Color.appGreen)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
            
            // Time
            HStack(spacing: Spacing.sm) {
                Image(systemName: "clock")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.appGreen)
                
                DatePicker(
                    "",
                    selection: $viewModel.order.scheduledDate,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(Color.appGreen)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.bgPrimary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.md))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
        }
    }
}

// MARK: - Comment
private extension TaxiView {
    
    var commentSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(L10n.Taxi.comment)
                .font(.system(size: 13))
                .foregroundStyle(Color.textSecondary)
            
            TextField(L10n.Taxi.commentPlaceholder, text: $viewModel.order.comment, axis: .vertical)
                .font(.system(size: 14))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(3...5)
                .padding(Spacing.md)
                .background(Color.bgPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Radius.md))
                .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
        }
    }
}

// MARK: - Payment
private extension TaxiView {
    
    var paymentSection: some View {
        HStack {
            Image(systemName: viewModel.order.paymentMethod.icon)
                .font(.system(size: 16))
                .foregroundStyle(Color.appGreen)
            
            Text(viewModel.order.paymentMethod.displayName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
            
            Text("•••• 4242")
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
            
            Spacer()
            
            Button(L10n.Taxi.paymentChange) {
                // show payment picker
            }
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color.appGreen)
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.md))
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
    }
}

// MARK: - CTA
private extension TaxiView {
    
    var ctaButton: some View {
        Button {
            Task { await viewModel.callTaxi() }
        } label: {
            HStack(spacing: Spacing.sm) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                }
                
                Text(L10n.Taxi.cta)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .background(viewModel.isFormValid ? Color.appGreen : Color.separator)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .animation(.easeOut, value: viewModel.isFormValid)
        }
        .disabled(!viewModel.isFormValid || viewModel.isLoading)
        .padding(.horizontal, Spacing.md)
        .padding(.bottom, Spacing.md)
    }
}

#Preview {
    TaxiView()
}
