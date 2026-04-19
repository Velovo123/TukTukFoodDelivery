//
//  AppContainer.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 19.04.2026.
//

import SwiftUI

@Observable
final class AppContainer {
    let cart = CartManager()
}

private struct AppContainerKey: EnvironmentKey {
    static let defaultValue = AppContainer()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
