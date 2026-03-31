import SwiftUI

struct AdminHomeView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var selectedTab: AdminTab = .overview

    var body: some View {
        ZStack {
            // Refined background
            ZStack {
                LinearGradient(colors: [Palette.midnight, Palette.navy], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Palette.lavender.opacity(0.05), Color.clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 200
                        )
                    )
                    .frame(width: 400, height: 400)
                    .offset(x: 60, y: -80)
                    .blur(radius: 40)
            }

            ScrollView {
                VStack(spacing: 18) {
                    header
                    tabSwitcher
                    content
                }
                .padding(18)
            }
        }
        .navigationBarHidden(true)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text("Loofy")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.white)
                    Text("ADMIN")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            LinearGradient(colors: [Palette.lavender, Palette.mint], startPoint: .leading, endPoint: .trailing),
                            in: Capsule()
                        )
                }
                Text("Platform overview & controls")
                    .foregroundStyle(Palette.muted)
                    .font(.subheadline)
            }
            Spacer()
            Button(action: { session.signOut() }) {
                Image(systemName: "power")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.06), in: Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.08)))
            }
        }
    }

    private var tabSwitcher: some View {
        HStack {
            ForEach(AdminTab.allCases) { tab in
                let active = tab == selectedTab
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                } label: {
                    Text(tab.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(active ? .white : .white.opacity(0.6))
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            active ?
                                AnyShapeStyle(LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing)) :
                                AnyShapeStyle(Color.white.opacity(0.06))
                        )
                        .clipShape(Capsule())
                }
            }
        }
        .padding(4)
        .background(Color.white.opacity(0.04), in: Capsule())
        .overlay(Capsule().stroke(Color.white.opacity(0.06)))
    }

    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .overview:
            OverviewContent()
        case .merchants:
            MerchantsContent()
        case .rules:
            RulesContent()
        case .reports:
            ReportsContent()
        }
    }
}

private enum AdminTab: String, CaseIterable, Identifiable {
    case overview, merchants, rules, reports
    var id: String { rawValue }
    var title: String {
        switch self {
        case .overview: return "Overview"
        case .merchants: return "Merchants"
        case .rules: return "Rules"
        case .reports: return "Reports"
        }
    }
}

// MARK: - Overview

private struct OverviewContent: View {
    var body: some View {
        VStack(spacing: 14) {
            // Platform health
            VStack(alignment: .leading, spacing: 12) {
                Text("Platform Health")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                HStack(spacing: 14) {
                    MetricCard(title: "Active Users", value: "12,430", delta: "+4.2%", color: Palette.mint)
                    MetricCard(title: "Merchants", value: "148", delta: "+12", color: Palette.lavender)
                }
                HStack(spacing: 14) {
                    MetricCard(title: "Redemptions", value: "3,482", delta: "+18%", color: Palette.goldAccent)
                    MetricCard(title: "Revenue", value: "$4.2K", delta: "+22%", color: Palette.magenta)
                }
            }

            // Engagement metrics
            VStack(alignment: .leading, spacing: 12) {
                Text("Engagement")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                HStack(spacing: 14) {
                    EngagementCard(title: "Repeat Visit Rate", value: "34%", target: "40%", progress: 0.85)
                    EngagementCard(title: "Wallet Add Rate", value: "62%", target: "70%", progress: 0.88)
                }
            }

            // Live campaigns
            VStack(alignment: .leading, spacing: 10) {
                Text("Live Campaigns")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                CampaignRow(title: "Spring Boost", status: "Live", merchants: 42, color: .green)
                CampaignRow(title: "Weekend Multiplier", status: "Scheduled", merchants: 18, color: .orange)
                CampaignRow(title: "Referral Month", status: "Live", merchants: 67, color: .green)
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)

            // Recent alerts
            VStack(alignment: .leading, spacing: 10) {
                Text("System Alerts")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                AlertRow(icon: "exclamationmark.triangle.fill", message: "High redemption velocity detected at 3 merchants", severity: .warning)
                AlertRow(icon: "shield.fill", message: "12 fraud attempts blocked today", severity: .info)
                AlertRow(icon: "checkmark.shield.fill", message: "All systems operational", severity: .success)
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)
        }
    }
}

private struct EngagementCard: View {
    let title: String
    let value: String
    let target: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.white.opacity(0.75))
                .font(.caption)
            Text(value)
                .foregroundStyle(.white)
                .font(.title3.weight(.bold))
            HStack(spacing: 4) {
                Text("Target: \(target)")
                    .foregroundStyle(Palette.muted)
                    .font(.caption2)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.08))
                        .frame(height: 4)
                    Capsule()
                        .fill(
                            LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(width: geo.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
    }
}

private enum AlertSeverity {
    case warning, info, success

    var color: Color {
        switch self {
        case .warning: return .orange
        case .info: return Palette.lavender
        case .success: return .green
        }
    }
}

private struct AlertRow: View {
    let icon: String
    let message: String
    let severity: AlertSeverity

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(severity.color)
                .frame(width: 20)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Merchants Management

private struct MerchantsContent: View {
    @State private var searchText = ""

    private let merchants: [(name: String, plan: String, members: Int, status: String)] = [
        ("Bean & Brew Coffee", "Pro", 234, "Active"),
        ("Fresh Cuts Salon", "Free", 56, "Active"),
        ("Zen Yoga Studio", "Pro", 189, "Active"),
        ("Mario's Pizza", "Free", 23, "Pending"),
        ("City Gym", "Business", 412, "Active"),
        ("Book Nook", "Free", 8, "Trial")
    ]

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("All Merchants")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Text("\(merchants.count) total")
                    .font(.caption)
                    .foregroundStyle(Palette.muted)
            }

            // Search
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Palette.muted)
                TextField("Search merchants...", text: $searchText)
                    .foregroundStyle(.white)
            }
            .padding(14)
            .glassCard(cornerRadius: 14, opacity: 0.06, strokeOpacity: 0.08)

            // Plan summary
            HStack(spacing: 12) {
                PlanBadge(plan: "Free", count: 3, color: Palette.muted)
                PlanBadge(plan: "Pro", count: 2, color: Palette.mint)
                PlanBadge(plan: "Business", count: 1, color: Palette.goldAccent)
            }

            ForEach(merchants, id: \.name) { merchant in
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(String(merchant.name.prefix(1)))
                                .font(.headline.weight(.bold))
                                .foregroundStyle(.white)
                        )

                    VStack(alignment: .leading, spacing: 3) {
                        Text(merchant.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("\(merchant.members) members • \(merchant.plan)")
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    Text(merchant.status)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(statusColor(merchant.status))
                }
                .padding(14)
                .glassCard(cornerRadius: 16, opacity: 0.05, strokeOpacity: 0.08)
            }
        }
    }

    private func statusColor(_ status: String) -> Color {
        switch status {
        case "Active": return .green
        case "Pending": return .orange
        case "Trial": return Palette.lavender
        default: return Palette.muted
        }
    }
}

private struct PlanBadge: View {
    let plan: String
    let count: Int
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text("\(count) \(plan)")
                .font(.caption.weight(.medium))
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.04), in: Capsule())
        .overlay(Capsule().stroke(Color.white.opacity(0.06)))
    }
}

// MARK: - Rules

private struct RulesContent: View {
    @State private var earnRate: Double = 1.0
    @State private var redemptionRate: Double = 0.01
    @State private var managerApproval: Bool = false
    @State private var maxDailyStamps: Int = 5
    @State private var fraudDetection: Bool = true

    var body: some View {
        VStack(spacing: 14) {
            RuleCard(title: "Earning", content: {
                Stepper(value: $earnRate, in: 0.5...5, step: 0.5) {
                    row(label: "Default earn rate", value: "\(String(format: "%.1f", earnRate)) pts / $1")
                }
                Stepper(value: $maxDailyStamps, in: 1...20) {
                    row(label: "Max daily stamps", value: "\(maxDailyStamps)")
                }
            })
            RuleCard(title: "Redemption", content: {
                Stepper(value: $redemptionRate, in: 0.005...0.05, step: 0.005) {
                    row(label: "Value per point", value: "$\(String(format: "%.3f", redemptionRate))")
                }
            })
            RuleCard(title: "Security", content: {
                Toggle(isOn: $managerApproval) {
                    row(label: "Manager approval > $50", value: managerApproval ? "On" : "Off")
                }
                .toggleStyle(SwitchToggleStyle(tint: Palette.mint))
                Toggle(isOn: $fraudDetection) {
                    row(label: "Auto fraud detection", value: fraudDetection ? "On" : "Off")
                }
                .toggleStyle(SwitchToggleStyle(tint: Palette.mint))
            })
            RuleCard(title: "Program Defaults", content: {
                row(label: "Default stamps", value: "10")
                row(label: "Default expiry", value: "12 months")
                row(label: "Referral bonus", value: "50 pts each")
            })
        }
    }

    @ViewBuilder
    private func row(label: String, value: String) -> some View {
        HStack {
            Text(label).foregroundStyle(.white)
            Spacer()
            Text(value).foregroundStyle(.white.opacity(0.75))
        }
        .font(.subheadline)
    }
}

// MARK: - Reports

private struct ReportsContent: View {
    var body: some View {
        VStack(spacing: 14) {
            // Revenue chart placeholder
            VStack(alignment: .leading, spacing: 12) {
                Text("Monthly Revenue")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(["Jan", "Feb", "Mar", "Apr", "May", "Jun"], id: \.self) { month in
                        VStack(spacing: 6) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(
                                    LinearGradient(
                                        colors: [Palette.mint, Color(hex: "7C3AED")],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: 32, height: barHeight(for: month))
                            Text(month)
                                .font(.system(size: 9))
                                .foregroundStyle(Palette.muted)
                        }
                    }
                    Spacer()
                }
                .frame(height: 120, alignment: .bottom)
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)

            RuleCard(title: "Exports") {
                ButtonRow(title: "Send daily CSV report", icon: "tray.and.arrow.up")
                ButtonRow(title: "Export merchant data", icon: "doc.text")
                ButtonRow(title: "Customer segments export", icon: "person.2.square.stack")
            }

            RuleCard(title: "Audit Trail") {
                ForEach(sampleAudits, id: \.self) { entry in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(entry)
                                .foregroundStyle(.white)
                            Text("Today, 10:12 AM")
                                .foregroundStyle(.white.opacity(0.5))
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 6)
                    Divider().background(Color.white.opacity(0.06))
                }
            }
        }
    }

    private func barHeight(for month: String) -> CGFloat {
        let heights: [String: CGFloat] = [
            "Jan": 40, "Feb": 55, "Mar": 70,
            "Apr": 85, "May": 65, "Jun": 100
        ]
        return heights[month] ?? 50
    }

    private var sampleAudits: [String] {
        [
            "admin01 changed default earn rate",
            "ops02 approved new merchant: City Gym",
            "system flagged velocity threshold breach",
            "admin01 exported Q2 revenue report"
        ]
    }
}

// MARK: - Shared Components

private struct MetricCard: View {
    let title: String
    let value: String
    let delta: String
    var color: Color = Palette.mint

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundStyle(.white.opacity(0.75))
                .font(.subheadline)
            Text(value)
                .foregroundStyle(.white)
                .font(.title3.weight(.bold))
            Text(delta)
                .foregroundStyle(delta.contains("-") ? Color.red : color)
                .font(.caption.weight(.semibold))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
    }
}

private struct CampaignRow: View {
    let title: String
    let status: String
    var merchants: Int = 0
    let color: Color

    var body: some View {
        HStack {
            Circle().fill(color).frame(width: 10, height: 10)
            Text(title).foregroundStyle(.white)
            Spacer()
            if merchants > 0 {
                Text("\(merchants) merchants")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            Text(status)
                .font(.caption.weight(.medium))
                .foregroundStyle(.white.opacity(0.75))
        }
    }
}

private struct RuleCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)
            content
        }
        .padding(16)
        .glassCard(cornerRadius: 18, opacity: 0.06, strokeOpacity: 0.08)
    }
}

private struct ButtonRow: View {
    let title: String
    let icon: String
    var body: some View {
        Button {
            // action stub
        } label: {
            HStack {
                Image(systemName: icon)
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.3))
            }
            .foregroundStyle(.white)
            .padding(.vertical, 8)
        }
    }
}

struct AdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AdminHomeView()
                .environmentObject(SessionViewModel())
        }
    }
}
