import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Refined gradient background
            LinearGradient(colors: [Palette.midnight, Palette.midnightSoft, Palette.navy.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            // Ambient glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(hex: "7C3AED").opacity(0.08), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 400, height: 400)
                .offset(y: -100)
                .blur(radius: 40)

            ScrollView {
                VStack(spacing: 30) {
                    // Logo & branding
                    VStack(spacing: 14) {
                        ZStack {
                            // Outer glow
                            Circle()
                                .fill(Palette.mint.opacity(0.08))
                                .frame(width: 100, height: 100)
                                .blur(radius: 12)

                            Circle()
                                .fill(Palette.brandGradient)
                                .frame(width: 76, height: 76)
                                .shadow(color: Color(hex: "7C3AED").opacity(0.35), radius: 20, y: 8)
                                .overlay(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [.white.opacity(0.25), .clear],
                                                startPoint: .topLeading,
                                                endPoint: .center
                                            )
                                        )
                                        .padding(2)
                                )
                                .overlay(
                                    Image(systemName: "creditcard.fill")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.white)
                                )
                        }
                        .scaleEffect(appeared ? 1.0 : 0.6)
                        .opacity(appeared ? 1 : 0)

                        Text("Loofy")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : 8)

                        Text("Digital loyalty made simple")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(Palette.muted)
                            .tracking(0.3)
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : 6)
                    }
                    .padding(.top, 44)

                    // Role selection
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Continue as")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                            .padding(.horizontal, 4)

                        ForEach(Array(UserRole.allCases.enumerated()), id: \.element) { index, role in
                            RoleCard(role: role) {
                                session.signIn(as: role)
                            }
                            .opacity(appeared ? 1 : 0)
                            .offset(y: appeared ? 0 : 20)
                            .animation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.2 + Double(index) * 0.08), value: appeared)
                        }
                    }

                    // Footer
                    VStack(spacing: 8) {
                        Text("Free to use • No credit card required")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(Palette.mint.opacity(0.7))
                        Text("Demo mode — connect your backend later")
                            .font(.caption)
                            .foregroundStyle(Palette.muted.opacity(0.7))
                    }
                    .padding(.top, 8)
                    .opacity(appeared ? 1 : 0)
                }
                .padding(24)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                appeared = true
            }
        }
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionView()
            .environmentObject(SessionViewModel())
    }
}
