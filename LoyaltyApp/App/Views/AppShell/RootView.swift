import SwiftUI

struct RootView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var showSplash = true

    var body: some View {
        ZStack {
            NavigationStack {
                Group {
                    if let role = session.role, session.isAuthenticated {
                        RoleRouter(role: role)
                    } else {
                        RoleSelectionView()
                    }
                }
                .animation(.easeInOut, value: session.isAuthenticated)
            }
            .opacity(showSplash ? 0 : 1)

            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSplash = false
                }
            }
        }
    }
}

struct RoleRouter: View {
    let role: UserRole
    @EnvironmentObject private var session: SessionViewModel

    var body: some View {
        switch role {
        case .customer:
            CustomerHomeView()
        case .merchant:
            MerchantHomeView()
        case .admin:
            AdminHomeView()
        }
    }
}
