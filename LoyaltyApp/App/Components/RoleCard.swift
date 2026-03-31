import SwiftUI

struct RoleCard: View {
    let role: UserRole
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Icon with gradient background + inner glow
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(accentGradient)
                        .frame(width: 50, height: 50)
                        .shadow(color: accentColor.opacity(0.3), radius: 8, y: 3)
                    
                    // Inner highlight
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [.white.opacity(0.25), .clear],
                                startPoint: .topLeading,
                                endPoint: .center
                            )
                        )
                        .frame(width: 50, height: 50)

                    Image(systemName: role.iconName)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(role.displayName)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Palette.muted)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.4))
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.06, strokeOpacity: 0.10)
            .shadow(color: Color.black.opacity(0.2), radius: 12, y: 6)
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
        case .merchant: return Color(hex: "7C3AED")
        case .admin: return Color(hex: "E8455E")
        }
    }

    private var accentGradient: LinearGradient {
        switch role {
        case .customer:
            return LinearGradient(colors: [Color(hex: "FFD89E"), Color(hex: "F5A623")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .merchant:
            return LinearGradient(colors: [Color(hex: "A78BFA"), Color(hex: "7C3AED")], startPoint: .topLeading, endPoint: .bottomTrailing)
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
        .background(Palette.midnight)
    }
}
