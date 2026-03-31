import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.3
    @State private var logoOpacity: Double = 0
    @State private var logoRotation: Double = -30
    @State private var taglineOpacity: Double = 0
    @State private var taglineOffset: CGFloat = 12
    @State private var ringScale: CGFloat = 0.5
    @State private var ringOpacity: Double = 0
    @State private var pulseScale: CGFloat = 1.0
    @State private var shimmerX: CGFloat = -1.0
    @State private var particlesVisible = false
    @State private var loaderOpacity: Double = 0
    @State private var lettersVisible: [Bool] = Array(repeating: false, count: 5)
    @State private var glowRotation: Double = 0

    private let appName: [Character] = Array("Loofy")
    private let letterColors: [Color] = [
        .white,
        .white,
        .white,
        .white,
        Palette.lavender
    ]

    var body: some View {
        ZStack {
            // Rich gradient background
            LinearGradient(
                colors: [Palette.midnight, Palette.midnightSoft, Palette.navy.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Ambient background glow orbs
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Palette.mint.opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .offset(x: -80, y: -200)
                .blur(radius: 60)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Palette.magenta.opacity(0.05), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 160
                    )
                )
                .frame(width: 320, height: 320)
                .offset(x: 120, y: 250)
                .blur(radius: 50)

            // Floating particles — softer, more organic
            ForEach(0..<10, id: \.self) { i in
                Circle()
                    .fill(
                        (i % 3 == 0 ? Palette.lavender : (i % 3 == 1 ? Palette.mint : Palette.rose))
                            .opacity(Double.random(in: 0.04...0.10))
                    )
                    .frame(width: CGFloat.random(in: 16...50))
                    .offset(
                        x: CGFloat.random(in: -160...160),
                        y: particlesVisible ? CGFloat.random(in: -340...340) : CGFloat.random(in: 100...400)
                    )
                    .blur(radius: CGFloat.random(in: 6...14))
                    .animation(
                        .easeInOut(duration: Double.random(in: 2.5...4.5))
                        .repeatForever(autoreverses: true)
                        .delay(Double(i) * 0.12),
                        value: particlesVisible
                    )
            }

            VStack(spacing: 24) {
                Spacer()

                // Logo with refined glow rings
                ZStack {
                    // Outer soft glow
                    Circle()
                        .fill(Palette.mint.opacity(0.04))
                        .frame(width: 200, height: 200)
                        .scaleEffect(pulseScale)
                        .opacity(ringOpacity * 0.6)

                    // Outer pulse ring
                    Circle()
                        .stroke(Palette.mint.opacity(0.08), lineWidth: 1.5)
                        .frame(width: 170, height: 170)
                        .scaleEffect(pulseScale)
                        .opacity(ringOpacity * 0.5)

                    // Glow ring
                    Circle()
                        .fill(Palette.mint.opacity(0.05))
                        .frame(width: 145, height: 145)
                        .scaleEffect(ringScale)
                        .opacity(ringOpacity)

                    // Rotating angular ring
                    Circle()
                        .stroke(
                            AngularGradient(
                                colors: [Palette.mint.opacity(0.25), Color.clear, Palette.lavender.opacity(0.2), Color.clear, Palette.mint.opacity(0.25)],
                                center: .center
                            ),
                            lineWidth: 1.5
                        )
                        .frame(width: 126, height: 126)
                        .scaleEffect(ringScale)
                        .opacity(ringOpacity)
                        .rotationEffect(.degrees(glowRotation))

                    // Main logo circle with refined gradient
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "8B5CF6"), Color(hex: "A78BFA"), Color(hex: "7C3AED")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 104, height: 104)
                        .shadow(color: Palette.mint.opacity(0.4), radius: 32, y: 8)
                        .shadow(color: Color(hex: "7C3AED").opacity(0.2), radius: 60, y: 16)
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.white.opacity(0.3), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .center
                                    )
                                )
                                .padding(2)
                        )
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.clear, .white.opacity(0.2), .clear],
                                        startPoint: UnitPoint(x: shimmerX, y: 0),
                                        endPoint: UnitPoint(x: shimmerX + 0.5, y: 1)
                                    )
                                )
                        )
                        .clipShape(Circle())
                        .overlay(
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 42, weight: .regular))
                                .foregroundStyle(.white.opacity(0.95))
                                .rotationEffect(.degrees(logoRotation))
                        )
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

                // Per-letter animated app name
                HStack(spacing: 3) {
                    ForEach(0..<appName.count, id: \.self) { index in
                        Text(String(appName[index]))
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(letterColors[index])
                            .shadow(color: letterColors[index].opacity(0.3), radius: 8, y: 2)
                            .scaleEffect(lettersVisible[index] ? 1.0 : 0.2)
                            .opacity(lettersVisible[index] ? 1.0 : 0)
                            .offset(y: lettersVisible[index] ? 0 : -30)
                            .rotationEffect(.degrees(lettersVisible[index] ? 0 : -20))
                    }
                }

                // Tagline with refined style
                Text("Digital loyalty made simple")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Palette.muted)
                    .tracking(0.5)
                    .opacity(taglineOpacity)
                    .offset(y: taglineOffset)

                Spacer()

                // Animated loader dots — refined with gradient
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { i in
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Palette.lavender, Palette.mint],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
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
            // Particles float in
            withAnimation(.easeOut(duration: 1.2)) {
                particlesVisible = true
            }

            // Logo enters with spring bounce
            withAnimation(.spring(response: 0.7, dampingFraction: 0.55).delay(0.15)) {
                logoScale = 1.0
                logoOpacity = 1.0
                logoRotation = 0
            }

            // Rings expand
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.3)) {
                ringScale = 1.0
                ringOpacity = 1.0
            }

            // Pulse ring animation
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true).delay(0.5)) {
                pulseScale = 1.12
            }

            // Rotating glow ring
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false).delay(0.5)) {
                glowRotation = 360
            }

            // Shimmer across logo
            withAnimation(.easeInOut(duration: 1.2).delay(0.4)) {
                shimmerX = 1.5
            }

            // Per-letter staggered animation
            for i in 0..<appName.count {
                withAnimation(
                    .spring(response: 0.45, dampingFraction: 0.55)
                    .delay(0.5 + Double(i) * 0.09)
                ) {
                    lettersVisible[i] = true
                }
            }

            // Tagline follows after all letters
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(1.1)) {
                taglineOpacity = 1.0
                taglineOffset = 0
            }

            // Loader dots appear
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
