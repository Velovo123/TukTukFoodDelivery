//
//  ProfileViewModel.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

@Observable
final class ProfileViewModel {
    
    var user: User? = User.preview
    var isLoading = false
    var errorMessage: String?
    var showSignOutAlert = false
    var showDeleteAlert = false
    
    // MARK: - Computed
    var isLoggedIn: Bool { user != nil }
    
    var bonusBalance: Double { user?.bonusBalance ?? 0 }
    var userName: String { user?.name ?? "" }
    
    // MARK: - Actions
    func loadUser() async {
        isLoading = true
        defer { isLoading = false }
        try? await Task.sleep(for: .seconds(0.5))
        user = User.preview
    }
    
    func signOut() {
        user = nil
    }
    
    func signIn(phone: String) async {
        isLoading = true
        defer { isLoading = false }
        try? await Task.sleep(for: .seconds(1))
        // Replace with real auth later
        user = User.preview
    }

    func deleteAccount() {
        // Clear all local data
        // API call to delete account goes here later
        user = nil
    }
}
