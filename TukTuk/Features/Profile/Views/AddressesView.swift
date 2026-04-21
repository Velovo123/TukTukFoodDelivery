
import SwiftUI

struct AddressesView: View {
    
    @State private var addresses = SavedAddress.previews
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.sm) {
                    if addresses.isEmpty {
                        emptyState
                    } else {
                        ForEach(addresses) { address in
                            addressRow(address)
                        }
                        
                        addButton
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.md)
                .padding(.bottom, Spacing.xl)
            }
            .background(Color.bgSurface)
            .navigationTitle(L10n.Profile.addresses)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


private extension AddressesView {
    
    func addressRow(_ address: SavedAddress) -> some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.xs)
                    .fill(Color.appGreenTint)
                    .frame(width: 40, height: 40)
                
                Image(systemName: address.icon)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appGreen)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(address.label)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.textPrimary)
                
                Text(address.address)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.textSecondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundStyle(Color.textTetriary)
        }
        .padding(Spacing.md)
        .background(Color.bgPrimary)
        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
    }
    
    var addButton: some View {
        Button {
            // add new address
        } label: {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.appGreen)
                
                Text("Add address")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appGreen)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .background(Color.appGreenTint)
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
        }
    }
    
    var emptyState: some View {
        VStack(spacing: Spacing.md) {
            Text("📍")
                .font(.system(size: 48))
            
            Text("No saved addresses")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
            
            Text("Add your home, work or other frequent locations")
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)
                .multilineTextAlignment(.center)
            
            addButton
        }
        .padding(.top, Spacing.xxxl)
    }
}

#Preview {
    AddressesView()
}
