import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.3
    @State private var logoOpacity: Double = 0
    @State private var taglineOpacity: Double = 0
    @State private var taglineOffset: CGFloat = 12
    @State private var particlesVisible = false
    @State private var loaderOpacity: Double = 0
    @State private var lettersVisible: [Bool] = Array(repeating: false, count: 5)

    private let appName: [Character] = Array("Loofy")

    var body: some View {
        ZStack {
            // Clean white background
            Color.white
                .ignoresSafeArea()

            // Subtle floating particles
            ForEach(0..<8, id: \.self) { i in
                Circle()
                    .fill(Color.black.opacity(Double.random(in: 0.02...0.04)))
                    .frame(width: CGFloat.random(in: 20...60))
                    .offset(
                        x: CGFloat.random(in: -160...160),
                        y: particlesVisible ? CGFloat.random(in: -340...340) : CGFloat.random(in: 100...400)
                    )
                    .blur(radius: CGFloat.random(in: 8...16))
                    .animation(
                        .easeInOut(duration: Double.random(in: 2.5...4.5))
                        .repeatForever(autoreverses: true)
                        .delay(Double(i) * 0.12),
                        value: particlesVisible
                    )
            }

            VStack(spacing: 24) {
                Spacer()

                // Logo
                Image("LoofyLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 320, height: 320)
                    .shadow(color: Color.black.opacity(0.1), radius: 24, y: 6)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                // Per-letter animated app name
                HStack(spacing: 3) {
                    ForEach(0..<appName.count, id: \.self) { index in
                        Text(String(appName[index]))
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(hex: "1A1A1A"))
                            .scaleEffect(lettersVisible[index] ? 1.0 : 0.2)
                            .opacity(lettersVisible[index] ? 1.0 : 0)
                            .offset(y: lettersVisible[index] ? 0 : -30)
                            .rotationEffect(.degrees(lettersVisible[index] ? 0 : -20))
                    }
                }

                // Tagline
                Text("Digital loyalty made simple")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Palette.muted)
                    .tracking(0.5)
                    .opacity(taglineOpacity)
                    .offset(y: taglineOffset)

                Spacer()

                // Animated loader dots
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .fill(Color(hex: "1A1A1A"))
                            .frame(width: 8, height: 8)
                            .scaleEffect(loaderOpacity > 0 ? 1 : 0.3)
                            .opacity(loaderOpacity > 0 ? 1 : 0.4)
                            .animation(
                                .easeInOut(duration: 0.55)
                                .repeatForever(autoreverses: true)
                                .delay(Double(i) * 0.18),
                                value: loaderOpacity
                            )
                    }
                }
                .opacity(loaderOpacity)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                particlesVisible = true
            }
            withAnimation(.spring(response: 0.7, dampingFraction: 0.55).delay(0.15)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            for i in 0..<appName.count {
                withAnimation(
                    .spring(response: 0.45, dampingFraction: 0.55)
                    .delay(0.5 + Double(i) * 0.09)
                ) {
                    lettersVisible[i] = true
                }
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(1.1)) {
                taglineOpacity = 1.0
                taglineOffset = 0
            }
            withAnimation(.easeOut(duration: 0.4).delay(1.3)) {
                loaderOpacity = 1.0
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
