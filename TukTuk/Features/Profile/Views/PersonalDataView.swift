
import SwiftUI

struct PersonalDataView: View {
    
    @State private var user = User.preview
    @State private var isEditing = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Spacing.sm) {
                avatarRow
                
                VStack(spacing: 0) {
                    dataRow(
                        icon: "person",
                        title: "Name",
                        value: user.name
                    )
                    
                    rowDivider
                    
                    dataRow(
                        icon: "phone",
                        title: "Phone",
                        value: user.phone
                    )
                    
                    rowDivider
                    
                    dataRow(
                        icon: "envelope",
                        title: "Email",
                        value: user.email ?? "—"
                    )
                }
                .background(Color.bgPrimary)
                .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.top, Spacing.md)
            .padding(.bottom, Spacing.xl)
        }
        .background(Color.bgSurface)
        .navigationTitle(L10n.Profile.personal)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Components
private extension PersonalDataView {
    
    var avatarRow: some View {
        VStack(spacing: Spacing.sm) {
            ZStack {
                Circle()
                    .fill(Color.appGreenMid)
                    .frame(width: 80, height: 80)
                
                Text(user.name.prefix(1))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color.appGreen)
            }
            
            Text(user.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.textPrimary)
            
            Text(user.phone)
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.lg)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
    }
    
    func dataRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(Color.appGreen)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
                
                Text(value)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.textPrimary)
            }
            
            Spacer()
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
    }
    
    var rowDivider: some View {
        Divider()
            .padding(.leading, 56)
    }
}

#Preview {
    NavigationStack {
        PersonalDataView()
    }
}
