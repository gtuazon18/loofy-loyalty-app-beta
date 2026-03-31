import SwiftUI

enum Palette {
    // Tier gradients
    static let silver = LinearGradient(colors: [Color(hex: "E8E0F0"), Color(hex: "B8A9D4")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gold = LinearGradient(colors: [Color(hex: "FFD89E"), Color(hex: "F5A623")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let platinum = LinearGradient(colors: [Color(hex: "E0E7FF"), Color(hex: "A5B4FC")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let diamond = LinearGradient(colors: [Color(hex: "1A1A1A"), Color(hex: "0A0A0A")], startPoint: .topLeading, endPoint: .bottomTrailing)

    // Core — clean white & black
    static let midnight = Color(hex: "FAFAFA")         // Near-white background
    static let midnightSoft = Color(hex: "F5F5F5")     // Soft gray background
    static let navy = Color(hex: "EFEFEF")              // Light gray
    static let ice = Color(hex: "FAFAFA")               // White
    static let goldAccent = Color(hex: "F5A623")        // Warm gold
    static let magenta = Color(hex: "FF6B8A")           // Soft coral pink
    static let mint = Color(hex: "1A1A1A")              // Primary accent — black
    static let muted = Color(hex: "999999")             // Medium gray
    static let cardStroke = Color.black.opacity(0.06)
    static let surface = Color.white

    // Accent colors
    static let peach = Color(hex: "FFAB91")
    static let lavender = Color(hex: "8B5CF6")
    static let sky = Color(hex: "3B82F6")
    static let rose = Color(hex: "F43F5E")
    static let lime = Color(hex: "22C55E")
    static let warmWhite = Color(hex: "FFFFFF")

    // Primary text
    static let textPrimary = Color(hex: "1A1A1A")
    static let textSecondary = Color(hex: "666666")

    // Primary gradients
    static let brandGradient = LinearGradient(
        colors: [Color(hex: "1A1A1A"), Color(hex: "333333")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let warmGradient = LinearGradient(
        colors: [Color(hex: "FF6B8A"), Color(hex: "FFB347")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let bgGradient = LinearGradient(
        colors: [Color(hex: "FFFFFF"), Color(hex: "F5F5F5")],
        startPoint: .top,
        endPoint: .bottom
    )

    // Subtle card glow
    static let glowGradient = LinearGradient(
        colors: [Color.black.opacity(0.02), Color.black.opacity(0.01)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Section gradient
    static let sectionGradient = LinearGradient(
        colors: [Color(hex: "F8F8F8"), Color(hex: "F0F0F0")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Clean Card Modifier

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.07
    var strokeOpacity: Double = 0.12

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.white)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.black.opacity(0.06), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 8, y: 4)
    }
}

// MARK: - Soft Shadow Modifier

struct SoftShadow: ViewModifier {
    var color: Color = .black
    var radius: CGFloat = 16
    var y: CGFloat = 8

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.06), radius: radius, y: y)
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20, opacity: Double = 0.07, strokeOpacity: Double = 0.12) -> some View {
        modifier(GlassCard(cornerRadius: cornerRadius, opacity: opacity, strokeOpacity: strokeOpacity))
    }

    func softShadow(color: Color = .black, radius: CGFloat = 16, y: CGFloat = 8) -> some View {
        modifier(SoftShadow(color: color, radius: radius, y: y))
    }
}

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hexSanitized.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}
