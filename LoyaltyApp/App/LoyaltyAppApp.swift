import SwiftUI

@main
struct LoyaltyAppApp: App {
    @StateObject private var session = SessionViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .preferredColorScheme(session.appearance.colorScheme)
        }
    }
}
