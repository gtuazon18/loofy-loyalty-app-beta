import SwiftUI

// MARK: - Facebook Icon

struct FacebookIcon: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "0866FF"))
                .frame(width: size, height: size)

            // White "f" letter shape
            FacebookFShape()
                .fill(.white)
                .frame(width: size * 0.45, height: size * 0.65)
                .offset(x: size * 0.04, y: size * 0.04)
        }
    }
}

private struct FacebookFShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Simplified "f" shape
        // Vertical bar
        path.move(to: CGPoint(x: w * 0.42, y: h))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.52))
        path.addLine(to: CGPoint(x: w * 0.15, y: h * 0.52))
        path.addLine(to: CGPoint(x: w * 0.15, y: h * 0.36))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.36))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.26))
        // Curve at top
        path.addQuadCurve(
            to: CGPoint(x: w * 0.85, y: h * 0.06),
            control: CGPoint(x: w * 0.42, y: h * 0.06)
        )
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.22))
        path.addLine(to: CGPoint(x: w * 0.72, y: h * 0.22))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.62, y: h * 0.30),
            control: CGPoint(x: w * 0.62, y: h * 0.22)
        )
        path.addLine(to: CGPoint(x: w * 0.62, y: h * 0.36))
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.36))
        path.addLine(to: CGPoint(x: w * 0.78, y: h * 0.52))
        path.addLine(to: CGPoint(x: w * 0.62, y: h * 0.52))
        path.addLine(to: CGPoint(x: w * 0.62, y: h))
        path.closeSubpath()

        return path
    }
}

// MARK: - TikTok Icon

struct TikTokIcon: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.22, style: .continuous)
                .fill(.black)
                .frame(width: size, height: size)

            // TikTok note symbol - layered for the brand look
            ZStack {
                // Cyan shadow layer
                TikTokNoteShape()
                    .fill(Color(hex: "00F2EA"))
                    .frame(width: size * 0.45, height: size * 0.55)
                    .offset(x: -size * 0.02, y: size * 0.015)

                // Red shadow layer
                TikTokNoteShape()
                    .fill(Color(hex: "FF004F"))
                    .frame(width: size * 0.45, height: size * 0.55)
                    .offset(x: size * 0.02, y: -size * 0.015)

                // White main layer
                TikTokNoteShape()
                    .fill(.white)
                    .frame(width: size * 0.45, height: size * 0.55)
            }
        }
    }
}

private struct TikTokNoteShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        // Musical note / d-shape representing TikTok
        // Vertical bar
        path.move(to: CGPoint(x: w * 0.42, y: 0))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.65))

        // Circle at bottom
        path.addQuadCurve(
            to: CGPoint(x: w * 0.10, y: h * 0.72),
            control: CGPoint(x: w * 0.15, y: h * 0.62)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.10, y: h * 0.95),
            control: CGPoint(x: w * 0.0, y: h * 0.85)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.42, y: h * 0.88),
            control: CGPoint(x: w * 0.28, y: h * 1.05)
        )
        path.addQuadCurve(
            to: CGPoint(x: w * 0.58, y: h * 0.68),
            control: CGPoint(x: w * 0.58, y: h * 0.85)
        )

        // Up the right side
        path.addLine(to: CGPoint(x: w * 0.58, y: h * 0.32))

        // Curve outward for the "wave" top
        path.addQuadCurve(
            to: CGPoint(x: w * 1.0, y: h * 0.18),
            control: CGPoint(x: w * 0.85, y: h * 0.32)
        )
        path.addLine(to: CGPoint(x: w * 1.0, y: h * 0.0))
        path.addQuadCurve(
            to: CGPoint(x: w * 0.58, y: h * 0.0),
            control: CGPoint(x: w * 0.58, y: h * 0.0)
        )

        path.addLine(to: CGPoint(x: w * 0.58, y: 0))
        path.closeSubpath()

        return path
    }
}

// MARK: - Instagram Icon

struct InstagramIcon: View {
    var size: CGFloat = 32

    var body: some View {
        ZStack {
            // Instagram gradient background
            RoundedRectangle(cornerRadius: size * 0.25, style: .continuous)
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "405DE6"), location: 0.0),
                            .init(color: Color(hex: "833AB4"), location: 0.25),
                            .init(color: Color(hex: "E1306C"), location: 0.5),
                            .init(color: Color(hex: "F77737"), location: 0.75),
                            .init(color: Color(hex: "FCAF45"), location: 0.95),
                            .init(color: Color(hex: "FFDC80"), location: 1.0)
                        ],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
                .frame(width: size, height: size)

            // Camera body (rounded rect outline)
            RoundedRectangle(cornerRadius: size * 0.15, style: .continuous)
                .stroke(.white, lineWidth: size * 0.06)
                .frame(width: size * 0.58, height: size * 0.58)

            // Camera lens (circle)
            Circle()
                .stroke(.white, lineWidth: size * 0.06)
                .frame(width: size * 0.28, height: size * 0.28)

            // Flash dot
            Circle()
                .fill(.white)
                .frame(width: size * 0.08, height: size * 0.08)
                .offset(x: size * 0.17, y: -size * 0.17)
        }
    }
}

// MARK: - Previews

struct SocialIcons_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            FacebookIcon(size: 48)
            TikTokIcon(size: 48)
            InstagramIcon(size: 48)
        }
        .padding()
        .background(Palette.midnight)
        .previewLayout(.sizeThatFits)
    }
}
