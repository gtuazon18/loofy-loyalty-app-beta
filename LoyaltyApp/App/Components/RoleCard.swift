import SwiftUI

struct RoleCard: View {
    let role: UserRole
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                // Icon with gradient background
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(accentGradient)
                        .frame(width: 50, height: 50)
                        .shadow(color: accentColor.opacity(0.2), radius: 8, y: 3)

                    Image(systemName: role.iconName)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(role.displayName)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Palette.muted)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Palette.muted)
            }
            .padding(16)
            .glassCard(cornerRadius: 18)
        }
        .buttonStyle(.plain)
    }

    private var subtitle: String {
        switch role {
        case .customer: return "Earn & redeem points"
        case .merchant: return "Scan customers, apply rewards"
        case .admin: return "Configure rules & offers"
        }
    }

    private var accentColor: Color {
        switch role {
        case .customer: return Color(hex: "F5A623")
        case .merchant: return Color(hex: "1A1A1A")
        case .admin: return Color(hex: "E8455E")
        }
    }

    private var accentGradient: LinearGradient {
        switch role {
        case .customer:
            return LinearGradient(colors: [Color(hex: "FFD89E"), Color(hex: "F5A623")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .merchant:
            return LinearGradient(colors: [Color(hex: "333333"), Color(hex: "1A1A1A")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .admin:
            return LinearGradient(colors: [Color(hex: "FF6B8A"), Color(hex: "E8455E")], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

struct RoleCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoleCard(role: .customer, action: {})
            RoleCard(role: .merchant, action: {})
            RoleCard(role: .admin, action: {})
        }
        .padding()
        .background(Color.white)
    }
}
