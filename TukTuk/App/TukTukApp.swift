//
//  TukTukApp.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

@main
struct TukTukApp: App {
    @State private var container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.appContainer, container)
        }
    }
}
