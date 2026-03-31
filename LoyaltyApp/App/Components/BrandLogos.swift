import SwiftUI

// MARK: - Starbucks Logo

struct StarbucksLogo: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            // Green circle background
            Circle()
                .fill(Color(hex: "00704A"))
                .frame(width: size, height: size)

            // White ring
            Circle()
                .stroke(.white, lineWidth: size * 0.04)
                .frame(width: size * 0.82, height: size * 0.82)

            // Simplified siren using overlapping shapes
            StarbucksSiren()
                .fill(.white)
                .frame(width: size * 0.5, height: size * 0.6)
        }
    }
}

private struct StarbucksSiren: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let cx = w * 0.5

        // Crown/head
        path.move(to: CGPoint(x: cx, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: cx + w * 0.12, y: h * 0.08),
            control: CGPoint(x: cx + w * 0.08, y: 0)
        )
        // Star points on crown
        path.addLine(to: CGPoint(x: cx + w * 0.06, y: h * 0.14))
        path.addLine(to: CGPoint(x: cx + w * 0.15, y: h * 0.12))
        path.addLine(to: CGPoint(x: cx + w * 0.10, y: h * 0.18))

        // Right side - face/hair flowing down
        path.addQuadCurve(
            to: CGPoint(x: cx + w * 0.30, y: h * 0.40),
            control: CGPoint(x: cx + w * 0.28, y: h * 0.25)
        )

        // Right tail curving outward
        path.addQuadCurve(
            to: CGPoint(x: cx + w * 0.45, y: h * 0.70),
            control: CGPoint(x: cx + w * 0.42, y: h * 0.52)
        )

        // Right tail tip curving back
        path.addQuadCurve(
            to: CGPoint(x: cx + w * 0.18, y: h * 0.85),
            control: CGPoint(x: cx + w * 0.45, y: h * 0.88)
        )

        // Bottom center
        path.addQuadCurve(
            to: CGPoint(x: cx, y: h * 0.95),
            control: CGPoint(x: cx + w * 0.08, y: h * 0.92)
        )

        // Mirror left side
        path.addQuadCurve(
            to: CGPoint(x: cx - w * 0.18, y: h * 0.85),
            control: CGPoint(x: cx - w * 0.08, y: h * 0.92)
        )

        path.addQuadCurve(
            to: CGPoint(x: cx - w * 0.45, y: h * 0.70),
            control: CGPoint(x: cx - w * 0.45, y: h * 0.88)
        )

        path.addQuadCurve(
            to: CGPoint(x: cx - w * 0.30, y: h * 0.40),
            control: CGPoint(x: cx - w * 0.42, y: h * 0.52)
        )

        path.addQuadCurve(
            to: CGPoint(x: cx - w * 0.10, y: h * 0.18),
            control: CGPoint(x: cx - w * 0.28, y: h * 0.25)
        )

        // Left crown
        path.addLine(to: CGPoint(x: cx - w * 0.15, y: h * 0.12))
        path.addLine(to: CGPoint(x: cx - w * 0.06, y: h * 0.14))
        path.addLine(to: CGPoint(x: cx - w * 0.12, y: h * 0.08))

        path.addQuadCurve(
            to: CGPoint(x: cx, y: 0),
            control: CGPoint(x: cx - w * 0.08, y: 0)
        )

        path.closeSubpath()
        return path
    }
}

// MARK: - McDonald's Logo

struct McDonaldsLogo: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            // Red circle background
            Circle()
                .fill(Color(hex: "DA291C"))
                .frame(width: size, height: size)

            // Golden arches "M"
            McDonaldsArches()
                .fill(Color(hex: "FFC72C"))
                .frame(width: size * 0.62, height: size * 0.52)
                .offset(y: size * 0.02)
        }
    }
}

private struct McDonaldsArches: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        let archWidth = w * 0.36
        let barWidth = w * 0.14

        // Left arch
        let leftCenter = w * 0.28

        // Left arch - outer edge (going up)
        path.move(to: CGPoint(x: leftCenter - barWidth / 2, y: h))
        path.addLine(to: CGPoint(x: leftCenter - barWidth / 2, y: h * 0.30))
        path.addQuadCurve(
            to: CGPoint(x: leftCenter, y: h * 0.04),
            control: CGPoint(x: leftCenter - barWidth / 2, y: h * 0.08)
        )
        path.addQuadCurve(
            to: CGPoint(x: leftCenter + barWidth / 2, y: h * 0.30),
            control: CGPoint(x: leftCenter + barWidth / 2, y: h * 0.08)
        )

        // Dip down to center valley
        path.addLine(to: CGPoint(x: leftCenter + barWidth / 2, y: h * 0.65))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.5, y: h * 0.55),
            control: CGPoint(x: w * 0.40, y: h * 0.72)
        )

        // Right arch - inner edge going up
        let rightCenter = w * 0.72
        path.addQuadCurve(
            to: CGPoint(x: rightCenter - barWidth / 2, y: h * 0.65),
            control: CGPoint(x: w * 0.60, y: h * 0.72)
        )
        path.addLine(to: CGPoint(x: rightCenter - barWidth / 2, y: h * 0.30))
        path.addQuadCurve(
            to: CGPoint(x: rightCenter, y: h * 0.04),
            control: CGPoint(x: rightCenter - barWidth / 2, y: h * 0.08)
        )
        path.addQuadCurve(
            to: CGPoint(x: rightCenter + barWidth / 2, y: h * 0.30),
            control: CGPoint(x: rightCenter + barWidth / 2, y: h * 0.08)
        )

        // Right leg down
        path.addLine(to: CGPoint(x: rightCenter + barWidth / 2, y: h))

        // Bottom of right leg
        path.addLine(to: CGPoint(x: rightCenter + barWidth / 2 + barWidth * 0.2, y: h))
        path.addLine(to: CGPoint(x: rightCenter + barWidth / 2 + barWidth * 0.2, y: h * 0.25))

        // Right arch outer
        path.addQuadCurve(
            to: CGPoint(x: rightCenter, y: 0),
            control: CGPoint(x: rightCenter + archWidth / 2, y: 0)
        )
        path.addQuadCurve(
            to: CGPoint(x: rightCenter - barWidth / 2 - barWidth * 0.2, y: h * 0.25),
            control: CGPoint(x: rightCenter - archWidth / 2, y: 0)
        )

        // Valley at bottom between arches
        path.addLine(to: CGPoint(x: rightCenter - barWidth / 2 - barWidth * 0.2, y: h * 0.58))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.5, y: h * 0.42),
            control: CGPoint(x: w * 0.60, y: h * 0.58)
        )
        path.addQuadCurve(
            to: CGPoint(x: leftCenter + barWidth / 2 + barWidth * 0.2, y: h * 0.58),
            control: CGPoint(x: w * 0.40, y: h * 0.58)
        )

        path.addLine(to: CGPoint(x: leftCenter + barWidth / 2 + barWidth * 0.2, y: h * 0.25))

        // Left arch outer
        path.addQuadCurve(
            to: CGPoint(x: leftCenter, y: 0),
            control: CGPoint(x: leftCenter + archWidth / 2, y: 0)
        )
        path.addQuadCurve(
            to: CGPoint(x: leftCenter - barWidth / 2 - barWidth * 0.2, y: h * 0.25),
            control: CGPoint(x: leftCenter - archWidth / 2, y: 0)
        )
        path.addLine(to: CGPoint(x: leftCenter - barWidth / 2 - barWidth * 0.2, y: h))

        path.closeSubpath()
        return path
    }
}

// MARK: - Merchant Logo View Helper

struct MerchantLogoView: View {
    let logoType: MerchantLogoType
    let fallbackIcon: String
    var size: CGFloat = 20

    var body: some View {
        switch logoType {
        case .sfSymbol(let name):
            Image(systemName: name.isEmpty ? fallbackIcon : name)
                .font(.system(size: size))
                .foregroundStyle(.white.opacity(0.9))
        case .starbucks:
            StarbucksLogo(size: size * 1.8)
        case .mcdonalds:
            McDonaldsLogo(size: size * 1.8)
        }
    }
}

// MARK: - Previews

struct BrandLogos_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StarbucksLogo(size: 64)
            McDonaldsLogo(size: 64)
        }
        .padding()
        .background(Palette.midnight)
        .previewLayout(.sizeThatFits)
    }
}
