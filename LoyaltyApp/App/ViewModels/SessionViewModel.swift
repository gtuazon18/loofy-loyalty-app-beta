import Foundation
import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: String { rawValue }

    var label: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

final class SessionViewModel: ObservableObject {
    @Published var role: UserRole? = nil
    @Published var isAuthenticated: Bool = false
    @Published var username: String = ""
    @Published var appearance: AppAppearance = .system

    init() {
        // Restore saved appearance
        if let saved = UserDefaults.standard.string(forKey: "appAppearance"),
           let mode = AppAppearance(rawValue: saved) {
            appearance = mode
        }
    }

    func signIn(as role: UserRole, username: String = "") {
        self.role = role
        self.username = username.isEmpty ? defaultUsername(for: role) : username
        self.isAuthenticated = true
    }

    func signOut() {
        isAuthenticated = false
        role = nil
        username = ""
    }

    func setAppearance(_ mode: AppAppearance) {
        appearance = mode
        UserDefaults.standard.set(mode.rawValue, forKey: "appAppearance")
    }

    private func defaultUsername(for role: UserRole) -> String {
        switch role {
        case .customer: return "Pat Lee"
        case .merchant: return "Store Lead"
        case .admin: return "Ops Admin"
        }
    }
}
