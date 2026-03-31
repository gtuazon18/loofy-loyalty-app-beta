import SwiftUI

// MARK: - Facebook Icon

struct FacebookIcon: View {
    var size: CGFloat = 32

    var body: some View {
        Image("FacebookIcon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(Circle())
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
        Image("InstagramIcon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
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
