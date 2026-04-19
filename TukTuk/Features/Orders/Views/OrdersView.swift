//
//  OrdersView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct OrdersView: View {
    
    @State private var viewModel = OrdersViewModel()
    var isPushed: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if !isPushed {
                headerView
                segmentControl
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.sm) {
                    if viewModel.isLoading {
                        loadingState
                    } else if viewModel.currentOrders.isEmpty {
                        emptyState
                    } else {
                        ForEach(viewModel.currentOrders) { order in
                            OrderRow(order: order)
                        }
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.md)
                .padding(.bottom, Spacing.xl)
            }
            .background(Color.bgSurface)
        }
        .background(Color.bgSurface)
        .navigationTitle(isPushed ? L10n.Orders.title : "")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadOrders()
        }
    }
}

// MARK: - Header
private extension OrdersView {
    
    var headerView: some View {
        HStack(spacing: Spacing.sm) {
            Text(L10n.Orders.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            
            Spacer()
        }
        .padding(.horizontal, Spacing.md)
        .padding(.top, Spacing.lg)
        .padding(.bottom, Spacing.sm)
        .background(Color.bgSurface)
    }
}

// MARK: - Segment
private extension OrdersView {
    
    var segmentControl: some View {
        HStack(spacing: 0) {
            ForEach(OrderSegment.allCases, id: \.self) { segment in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.selectedSegment = segment
                    }
                } label: {
                    VStack(spacing: Spacing.xs) {
                        Text(segment.title)
                            .font(.system(size: 15, weight: viewModel.selectedSegment == segment ? .semibold : .regular))
                            .foregroundStyle(
                                viewModel.selectedSegment == segment
                                ? Color.textPrimary
                                : Color.textSecondary
                            )
                        
                        Rectangle()
                            .fill(viewModel.selectedSegment == segment
                                  ? Color.appGreen
                                  : Color.clear)
                            .frame(height: 2)
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, Spacing.md)
        .background(Color.bgSurface)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.separator)
                .frame(height: 1)
        }
    }
}

// MARK: - States
private extension OrdersView {
    
    var loadingState: some View {
        VStack(spacing: Spacing.sm) {
            ForEach(0..<3, id: \.self) { _ in
                SkeletonRow(height: 100, cornerRadius: Radius.lg)
            }
        }
    }
    
    var emptyState: some View {
        VStack(spacing: Spacing.md) {
            Text(viewModel.selectedSegment == .active ? "🚕" : "📋")
                .font(.system(size: 56))
            
            Text(L10n.Orders.empty)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
            
            Text(L10n.Orders.emptySub)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Spacing.xxxl)
    }
}

#Preview {
    OrdersView()
}

