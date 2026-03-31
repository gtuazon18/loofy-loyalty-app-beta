import Foundation
import SwiftUI
import Combine

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

struct AppNotification: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let body: String
    let time: String
    let color: Color
    var isRead: Bool = false
}

final class SessionViewModel: ObservableObject {
    @Published var role: UserRole? = nil
    @Published var isAuthenticated: Bool = false
    @Published var username: String = ""
    @Published var appearance: AppAppearance = .system
    @Published var notifications: [AppNotification] = AppNotification.sampleData
    @Published var totalPoints: Int = 8240
    @Published var redeemedRewardIDs: Set<String> = []

    var unreadCount: Int { notifications.filter { !$0.isRead }.count }

    init() {
        // Restore saved appearance
        if let saved = UserDefaults.standard.string(forKey: "appAppearance"),
           let mode = AppAppearance(rawValue: saved) {
            appearance = mode
        }
    }

    func markAllRead() {
        for i in notifications.indices {
            notifications[i].isRead = true
        }
    }

    func markRead(_ id: UUID) {
        if let idx = notifications.firstIndex(where: { $0.id == id }) {
            notifications[idx].isRead = true
        }
    }

    func redeemReward(id: String, cost: Int) {
        guard totalPoints >= cost, !redeemedRewardIDs.contains(id) else { return }
        totalPoints -= cost
        redeemedRewardIDs.insert(id)
        let note = AppNotification(
            icon: "gift.fill",
            title: "Reward Redeemed!",
            body: "You redeemed a reward for \(cost) pts.",
            time: "Just now",
            color: Color(hex: "34C759")
        )
        notifications.insert(note, at: 0)
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

extension AppNotification {
    static let sampleData: [AppNotification] = [
        AppNotification(
            icon: "plus.circle.fill",
            title: "Points Earned",
            body: "You earned 50 pts at Bean & Brew Coffee.",
            time: "2h ago",
            color: Color(hex: "1B3A2D")
        ),
        AppNotification(
            icon: "star.fill",
            title: "New Stamp",
            body: "You got a new stamp at PCA Carwash!",
            time: "Yesterday",
            color: Color(hex: "3B82F6")
        ),
        AppNotification(
            icon: "gift.fill",
            title: "Reward Available",
            body: "You have enough points for a Free Large Coffee.",
            time: "2 days ago",
            color: Color(hex: "34C759")
        ),
        AppNotification(
            icon: "megaphone.fill",
            title: "New Promotion",
            body: "Fresh Cuts Salon: Double stamps this weekend!",
            time: "3 days ago",
            color: Color(hex: "E8455E")
        ),
        AppNotification(
            icon: "trophy.fill",
            title: "Milestone",
            body: "You've collected 25 stamps total. Keep going!",
            time: "1 week ago",
            color: Color(hex: "F5A623"),
            isRead: true
        )
    ]
}
