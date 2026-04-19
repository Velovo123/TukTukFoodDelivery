//
//  MainTabView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FoodView()
                .tabItem {
                    Label(L10n.Tab.food, systemImage: "fork.knife")
                }

            TaxiView()
                .tabItem {
                    Label(L10n.Tab.taxi, systemImage: "car.fill")
                }

            OrdersView()
                .tabItem {
                    Label(L10n.Tab.orders, systemImage: "bag")
                }

            ProfileView()
                .tabItem {
                    Label(L10n.Tab.profile, systemImage: "person")
                }
        }
        .tint(.appGreen)
    }
}

#Preview {
    MainTabView()
}
