//
//  ProfileView.swift
//  TukTuk
//
//  Created by Anatolii Semenchuk on 18.04.2026.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoggedIn {
                    loggedInView
                } else {
                    loginView
                }
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.loadUser()
            }
            .alert(L10n.Alert.signOutTitle, isPresented: $viewModel.showSignOutAlert) {
                Button(L10n.Profile.logout, role: .destructive) {
                    viewModel.signOut()
                }
                Button(L10n.Alert.cancel, role: .cancel) {}
            } message: {
                Text(L10n.Alert.signOutMessage)
            }
            .alert(L10n.Alert.deleteTitle, isPresented: $viewModel.showDeleteAlert) {
                Button(L10n.Alert.confirm, role: .destructive) {
                    viewModel.deleteAccount()
                }
                Button(L10n.Alert.cancel, role: .cancel) {}
            } message: {
                Text(L10n.Alert.deleteMessage)
            }
        }
    }
}


private extension ProfileView {

    var loggedInView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Spacing.md) {
                avatarSection
                bonusCard
                menuSection
                signOutButton
                deleteButton
            }
            .padding(.horizontal, Spacing.md)
            .padding(.bottom, Spacing.lg)
        }
        .background(Color.bgSurface)
    }

    var loginView: some View {
        LoginView { phone in
            await viewModel.signIn(phone: phone)
        }
    }
}


private extension ProfileView {
    
    var avatarSection: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(Color.appGreenMid)
                    .frame(width: 64, height: 64)
                
                Text(viewModel.userName.prefix(1))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.appGreen)
            }
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(L10n.Profile.cabinet)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
                
                Text(viewModel.userName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
            }
            
            Spacer()
        }
        .padding(.top, Spacing.lg)
    }
}


private extension ProfileView {
    
    var bonusCard: some View {
        ZStack(alignment: .trailing) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(L10n.Profile.bonus)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.75))
                    .textCase(.uppercase)
                    .kerning(1)
                
                Text("\(Int(viewModel.bonusBalance)) ₴")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)
                
                Text(L10n.Profile.bonusAvailable)
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.6))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.lg)
            
            Text("⭐")
                .font(.system(size: 64))
                .opacity(0.12)
                .padding(.trailing, Spacing.lg)
        }
        .background(
            LinearGradient(
                colors: [Color.appGreen, Color.appGreenDark],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: Radius.xl))
        .shadow(color: Color.appGreen.opacity(0.4), radius: 16, y: 6)
    }
}


private extension ProfileView {
    
    var menuSection: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: OrdersView(isPushed: true)) {
                ProfileMenuRow(
                    icon: "doc.text",
                    title: L10n.Profile.orders,
                    subtitle: L10n.Profile.ordersSub
                )
            }
            .buttonStyle(.plain)
            
            rowDivider
            
            NavigationLink(destination: PersonalDataView()) {
                ProfileMenuRow(
                    icon: "person",
                    title: L10n.Profile.personal,
                    subtitle: L10n.Profile.personalSub
                )
            }
            .buttonStyle(.plain)
            
            rowDivider
            
            NavigationLink(destination: AddressesView()) {
                ProfileMenuRow(
                    icon: "mappin.and.ellipse",
                    title: L10n.Profile.addresses,
                    subtitle: L10n.Profile.addressesSub
                )
            }
            .buttonStyle(.plain)
            
            rowDivider
            
            ProfileMenuRow(
                icon: "bell",
                title: L10n.Profile.notifications,
                subtitle: viewModel.user?.notificationsEnabled == true
                    ? L10n.Profile.notifOn
                    : L10n.Profile.notifOff,
                showToggle: true,
                toggleValue: Binding(
                    get: { viewModel.user?.notificationsEnabled ?? false },
                    set: { viewModel.user?.notificationsEnabled = $0 }
                )
            )
        }
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
    }
    
    var rowDivider: some View {
        Divider()
            .padding(.leading, 56)
    }
}


private extension ProfileView {
    
    var signOutButton: some View {
        Button {
            viewModel.showSignOutAlert = true
        } label: {
            Text(L10n.Profile.logout)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.destructive)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(Color.bgPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
        }
    }
    
    var deleteButton: some View {
        Button {
            viewModel.showDeleteAlert = true
        } label: {
            Text(L10n.Profile.delete)
                .font(.system(size: 14))
                .foregroundStyle(Color.textTetriary)
        }
        .padding(.bottom, Spacing.sm)
    }
}

#Preview {
    ProfileView()
}
