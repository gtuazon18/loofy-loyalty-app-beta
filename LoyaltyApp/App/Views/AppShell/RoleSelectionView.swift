import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Clean white background
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    // Logo & branding
                    VStack(spacing: 14) {
                        Image("LoofyLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .scaleEffect(appeared ? 2.0 : 0.6)
                            .opacity(appeared ? 1 : 0)

                        Text("Loofy")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(Palette.textPrimary)
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
                            .foregroundStyle(Palette.textPrimary)
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
                            .foregroundStyle(Palette.textSecondary)
                        Text("Demo mode — connect your backend later")
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
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
