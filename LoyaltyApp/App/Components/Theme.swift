import SwiftUI

enum Palette {
    // Tier gradients
    static let silver = LinearGradient(colors: [Color(hex: "E8E0F0"), Color(hex: "B8A9D4")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let gold = LinearGradient(colors: [Color(hex: "FFD89E"), Color(hex: "F5A623")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let platinum = LinearGradient(colors: [Color(hex: "E0E7FF"), Color(hex: "A5B4FC")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let diamond = LinearGradient(colors: [Color(hex: "2D1B4E"), Color(hex: "1A0F30")], startPoint: .topLeading, endPoint: .bottomTrailing)

    // Brand/core — warm & friendly
    static let midnight = Color(hex: "110B22")       // Richer deep purple
    static let midnightSoft = Color(hex: "1C1238")    // Soft purple-black
    static let navy = Color(hex: "271A4E")             // Warm indigo
    static let ice = Color(hex: "F0EAFF")              // Soft lavender white
    static let goldAccent = Color(hex: "FFB347")       // Warm friendly orange
    static let magenta = Color(hex: "FF6B8A")          // Soft coral pink
    static let mint = Color(hex: "A78BFA")             // Friendly purple (primary accent)
    static let muted = Color(hex: "8E82AB")            // Warm gray-purple (slightly more visible)
    static let cardStroke = Color.white.opacity(0.10)
    static let surface = Color.white.opacity(0.07)

    // Accent colors
    static let peach = Color(hex: "FFAB91")
    static let lavender = Color(hex: "C4B5FD")
    static let sky = Color(hex: "7DD3FC")
    static let rose = Color(hex: "FDA4AF")
    static let lime = Color(hex: "BEF264")
    static let warmWhite = Color(hex: "FBF7FF")

    // Primary gradients
    static let brandGradient = LinearGradient(
        colors: [Color(hex: "7C3AED"), Color(hex: "A78BFA")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let warmGradient = LinearGradient(
        colors: [Color(hex: "FF6B8A"), Color(hex: "FFB347")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let bgGradient = LinearGradient(
        colors: [Color(hex: "110B22"), Color(hex: "1C1238"), Color(hex: "271A4E")],
        startPoint: .top,
        endPoint: .bottom
    )

    // Aesthetic: soft glow gradient for cards
    static let glowGradient = LinearGradient(
        colors: [Color(hex: "A78BFA").opacity(0.15), Color(hex: "7C3AED").opacity(0.05)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Aesthetic: subtle shimmer for sections
    static let sectionGradient = LinearGradient(
        colors: [Color.white.opacity(0.08), Color.white.opacity(0.04)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Glassmorphism Card Modifier

struct GlassCard: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.07
    var strokeOpacity: Double = 0.12

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.white.opacity(opacity))
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(.ultraThinMaterial.opacity(0.3))
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(strokeOpacity), Color.white.opacity(strokeOpacity * 0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.8
                    )
            )
    }
}

// MARK: - Soft Shadow Modifier

struct SoftShadow: ViewModifier {
    var color: Color = Palette.mint
    var radius: CGFloat = 16
    var y: CGFloat = 8

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.15), radius: radius, y: y)
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 20, opacity: Double = 0.07, strokeOpacity: Double = 0.12) -> some View {
        modifier(GlassCard(cornerRadius: cornerRadius, opacity: opacity, strokeOpacity: strokeOpacity))
    }

    func softShadow(color: Color = Palette.mint, radius: CGFloat = 16, y: CGFloat = 8) -> some View {
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
