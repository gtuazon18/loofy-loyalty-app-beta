import SwiftUI

struct MerchantHomeView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var selectedTab: MerchantTab = .dashboard
    @State private var showScanner = false
    @State private var showCreateProgram = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Refined background
            ZStack {
                LinearGradient(colors: [Palette.midnightSoft, Palette.navy], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Palette.mint.opacity(0.04), Color.clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 220
                        )
                    )
                    .frame(width: 440, height: 440)
                    .offset(x: 80, y: -120)
                    .blur(radius: 40)
            }

            ScrollView {
                VStack(spacing: 18) {
                    switch selectedTab {
                    case .dashboard:
                        MerchantDashboardContent(showScanner: $showScanner, showCreateProgram: $showCreateProgram)
                    case .programs:
                        MerchantProgramsContent(showCreateProgram: $showCreateProgram)
                    case .scan:
                        EmptyView()
                    case .customers:
                        MerchantCustomersContent()
                    case .settings:
                        MerchantSettingsContent()
                    }
                }
                .padding(18)
                .padding(.bottom, 110)
            }

            MerchantTabBar(selectedTab: $selectedTab, showScanner: $showScanner)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Loofy")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                    Text("Merchant")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(Palette.mint)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Sign Out") { session.signOut() }
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .sheet(isPresented: $showScanner) {
            MerchantScannerView()
        }
        .sheet(isPresented: $showCreateProgram) {
            CreateProgramView()
        }
    }
}

// MARK: - Merchant Dashboard

private struct MerchantDashboardContent: View {
    @Binding var showScanner: Bool
    @Binding var showCreateProgram: Bool

    var body: some View {
        VStack(spacing: 18) {
            ScanHeroCard(showScanner: $showScanner)
            TodayStatsRow()
            MerchantQuickActions(showCreateProgram: $showCreateProgram)
            ActiveProgramsSummary()
            RecentTransactionsCard()
        }
    }
}

private struct ScanHeroCard: View {
    @Binding var showScanner: Bool

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ready to Scan")
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                    Text("Stamp or redeem customer rewards instantly")
                        .font(.subheadline)
                        .foregroundStyle(Palette.muted)
                }
                Spacer()
            }

            Button {
                showScanner = true
            } label: {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title2.weight(.bold))
                    Text("Open Scanner")
                        .font(.headline.weight(.semibold))
                }
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing),
                    in: RoundedRectangle(cornerRadius: 16)
                )
                .shadow(color: Palette.mint.opacity(0.2), radius: 10, y: 4)
            }
            .buttonStyle(.plain)
        }
        .padding(18)
        .glassCard(cornerRadius: 20, opacity: 0.06, strokeOpacity: 0.10)
    }
}

private struct TodayStatsRow: View {
    var body: some View {
        HStack(spacing: 12) {
            MerchantStatCard(title: "Today's Stamps", value: "47", icon: "seal.fill", color: Palette.mint)
            MerchantStatCard(title: "Redemptions", value: "8", icon: "gift.fill", color: Palette.goldAccent)
            MerchantStatCard(title: "New Members", value: "12", icon: "person.badge.plus", color: Palette.magenta)
        }
    }
}

private struct MerchantStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.title3)
            Text(value)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
            Text(title)
                .font(.system(size: 10))
                .foregroundStyle(Palette.muted)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
    }
}

private struct MerchantQuickActions: View {
    @Binding var showCreateProgram: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            HStack(spacing: 12) {
                ActionButton(title: "Add Stamp", icon: "seal", color: Palette.mint) {}
                ActionButton(title: "New Program", icon: "plus.rectangle.on.rectangle", color: Palette.goldAccent) {
                    showCreateProgram = true
                }
            }
            HStack(spacing: 12) {
                ActionButton(title: "Manual Entry", icon: "keyboard", color: Palette.lavender) {}
                ActionButton(title: "Send Offer", icon: "megaphone.fill", color: Palette.magenta) {}
            }
        }
    }
}

private struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .glassCard(cornerRadius: 14, opacity: 0.06, strokeOpacity: 0.08)
        }
        .buttonStyle(.plain)
    }
}

private struct ActiveProgramsSummary: View {
    private let programs: [(name: String, type: String, members: Int, active: Bool)] = [
        ("Coffee Loyalty", "Stamp Card (10)", 234, true),
        ("Weekend Special", "Points x2", 189, true),
        ("Referral Bonus", "Refer a Friend", 56, false)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("My Programs")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Text("\(programs.count) total")
                    .font(.caption)
                    .foregroundStyle(Palette.muted)
            }

            ForEach(programs, id: \.name) { program in
                HStack(spacing: 12) {
                    Circle()
                        .fill(program.active ? Palette.mint.opacity(0.15) : Color.white.opacity(0.06))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: program.active ? "checkmark.seal.fill" : "pause.circle")
                                .foregroundStyle(program.active ? Palette.mint : Palette.muted)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(program.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text(program.type)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(program.members)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("members")
                            .font(.caption2)
                            .foregroundStyle(Palette.muted)
                    }
                }
                .padding(12)
                .background(Color.white.opacity(0.03), in: RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding(16)
        .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)
    }
}

private struct RecentTransactionsCard: View {
    private let transactions: [(name: String, action: String, time: String)] = [
        ("Sarah M.", "+1 stamp", "2 min ago"),
        ("James K.", "Reward redeemed", "15 min ago"),
        ("Lisa T.", "+1 stamp", "22 min ago"),
        ("Mike R.", "New member joined", "1 hr ago")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Transactions")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            ForEach(transactions, id: \.name) { tx in
                HStack {
                    Circle()
                        .fill(Palette.mint.opacity(0.1))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Text(String(tx.name.prefix(1)))
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(tx.name)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.white)
                        Text(tx.action)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    Text(tx.time)
                        .font(.caption)
                        .foregroundStyle(Palette.muted)
                }
                .padding(.vertical, 4)
            }
        }
        .padding(16)
        .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)
    }
}

// MARK: - Merchant Programs Content

private struct MerchantProgramsContent: View {
    @Binding var showCreateProgram: Bool

    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Text("Loyalty Programs")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Button {
                    showCreateProgram = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Palette.mint)
                }
            }

            ProgramDetailCard(
                name: "Coffee Loyalty",
                type: "Stamp Card",
                description: "Buy 9 coffees, get the 10th free",
                members: 234,
                stamps: 1872,
                redemptions: 187,
                isActive: true
            )

            ProgramDetailCard(
                name: "Weekend Special",
                type: "Double Points",
                description: "2x points on Saturday & Sunday",
                members: 189,
                stamps: 0,
                redemptions: 45,
                isActive: true
            )

            ProgramDetailCard(
                name: "Referral Bonus",
                type: "Refer a Friend",
                description: "Both get 50 bonus points",
                members: 56,
                stamps: 0,
                redemptions: 23,
                isActive: false
            )
        }
    }
}

private struct ProgramDetailCard: View {
    let name: String
    let type: String
    let description: String
    let members: Int
    let stamps: Int
    let redemptions: Int
    let isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(name)
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.white)
                        Text(isActive ? "ACTIVE" : "PAUSED")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                isActive ?
                                    LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing) :
                                    LinearGradient(colors: [Palette.muted, Palette.muted], startPoint: .leading, endPoint: .trailing),
                                in: Capsule()
                            )
                    }
                    Text(type)
                        .font(.subheadline)
                        .foregroundStyle(Palette.muted)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Palette.muted)
                        .padding(8)
                        .background(Color.white.opacity(0.06), in: Circle())
                }
            }

            Text(description)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            HStack(spacing: 0) {
                ProgramStat(value: "\(members)", label: "Members")
                if stamps > 0 {
                    ProgramStat(value: "\(stamps)", label: "Stamps")
                }
                ProgramStat(value: "\(redemptions)", label: "Redeemed")
            }
        }
        .padding(18)
        .glassCard(cornerRadius: 18, opacity: 0.06, strokeOpacity: 0.10)
    }
}

private struct ProgramStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)
            Text(label)
                .font(.caption)
                .foregroundStyle(Palette.muted)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Merchant Customers Content

private struct MerchantCustomersContent: View {
    @State private var searchText = ""

    private let customers: [(name: String, stamps: Int, totalVisits: Int, lastVisit: String)] = [
        ("Sarah Mitchell", 7, 24, "Today"),
        ("James Kim", 3, 12, "Yesterday"),
        ("Lisa Thompson", 10, 45, "2 days ago"),
        ("Mike Rodriguez", 1, 3, "1 week ago"),
        ("Anna Chen", 5, 18, "3 days ago")
    ]

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Customers")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Text("\(customers.count) total")
                    .font(.subheadline)
                    .foregroundStyle(Palette.muted)
            }

            // Search
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Palette.muted)
                TextField("Search customers...", text: $searchText)
                    .foregroundStyle(.white)
            }
            .padding(14)
            .glassCard(cornerRadius: 14, opacity: 0.06, strokeOpacity: 0.08)

            ForEach(customers, id: \.name) { customer in
                HStack(spacing: 14) {
                    Circle()
                        .fill(Palette.mint.opacity(0.1))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Text(String(customer.name.prefix(1)))
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(.white)
                        )

                    VStack(alignment: .leading, spacing: 3) {
                        Text(customer.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("\(customer.stamps) stamps • \(customer.totalVisits) visits")
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 3) {
                        Text(customer.lastVisit)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                        if customer.stamps >= 10 {
                            Text("REWARD!")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(
                                    LinearGradient(colors: [Palette.goldAccent, Color(hex: "F5A623")], startPoint: .leading, endPoint: .trailing),
                                    in: Capsule()
                                )
                        }
                    }
                }
                .padding(14)
                .glassCard(cornerRadius: 16, opacity: 0.05, strokeOpacity: 0.08)
            }
        }
    }
}

// MARK: - Merchant Settings Content

private struct MerchantSettingsContent: View {
    var body: some View {
        VStack(spacing: 18) {
            // Store info
            VStack(alignment: .leading, spacing: 14) {
                Text("Store Details")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                MerchantSettingRow(label: "Store Name", value: "Bean & Brew Coffee")
                MerchantSettingRow(label: "Location", value: "123 Market Street")
                MerchantSettingRow(label: "Device", value: "iPad Front 01")
                MerchantSettingRow(label: "Status", value: "Online", accent: .green)
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)

            // Options
            VStack(alignment: .leading, spacing: 14) {
                Text("Preferences")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                MerchantSettingButton(title: "Branding & Colors", icon: "paintpalette")
                MerchantSettingButton(title: "Notification Settings", icon: "bell.badge")
                MerchantSettingButton(title: "Staff Accounts", icon: "person.2")
                MerchantSettingButton(title: "POS Integration", icon: "creditcard.and.123")
                MerchantSettingButton(title: "Export Data", icon: "square.and.arrow.up")
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)

            // Plan info
            VStack(alignment: .leading, spacing: 10) {
                Text("Your Plan")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Free Plan")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Palette.mint)
                        Text("Up to 100 members • 1 program")
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }
                    Spacer()
                    Button("Upgrade") {}
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            LinearGradient(colors: [Palette.goldAccent, Color(hex: "F5A623")], startPoint: .leading, endPoint: .trailing),
                            in: Capsule()
                        )
                        .shadow(color: Palette.goldAccent.opacity(0.2), radius: 6, y: 3)
                }
            }
            .padding(16)
            .glassCard(cornerRadius: 18, opacity: 0.05, strokeOpacity: 0.08)
        }
    }
}

private struct MerchantSettingRow: View {
    let label: String
    let value: String
    var accent: Color = .white

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.white.opacity(0.75))
            Spacer()
            Text(value)
                .foregroundStyle(accent)
        }
        .font(.subheadline)
    }
}

private struct MerchantSettingButton: View {
    let title: String
    let icon: String

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(Palette.muted)
                    .frame(width: 24)
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.white.opacity(0.25))
                    .font(.caption)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Merchant Scanner View

private struct MerchantScannerView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var manualCode = ""
    @State private var pointsToAdd: Int = 1
    @State private var scannedCustomer: String? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Palette.midnight, Palette.midnightSoft], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        if scannedCustomer == nil {
                            // Scanner area
                            VStack(spacing: 16) {
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .fill(Color.white.opacity(0.04))
                                    .frame(height: 280)
                                    .overlay(
                                        VStack(spacing: 16) {
                                            Image(systemName: "qrcode.viewfinder")
                                                .font(.system(size: 64))
                                                .foregroundStyle(Palette.mint)
                                            Text("Point camera at customer's QR code")
                                                .font(.subheadline)
                                                .foregroundStyle(Palette.muted)
                                        }
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22)
                                            .stroke(Palette.mint.opacity(0.25), lineWidth: 1.5)
                                    )

                                Text("OR enter code manually")
                                    .font(.caption)
                                    .foregroundStyle(Palette.muted)

                                HStack(spacing: 12) {
                                    TextField("Customer code", text: $manualCode)
                                        .padding(14)
                                        .glassCard(cornerRadius: 12, opacity: 0.06, strokeOpacity: 0.10)
                                        .foregroundStyle(.white)

                                    Button {
                                        scannedCustomer = "Sarah M."
                                    } label: {
                                        Text("Look Up")
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 14)
                                            .background(
                                                LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing),
                                                in: RoundedRectangle(cornerRadius: 12)
                                            )
                                    }
                                }
                            }
                        } else {
                            // Customer found
                            VStack(spacing: 20) {
                                VStack(spacing: 8) {
                                    Circle()
                                        .fill(Palette.mint.opacity(0.15))
                                        .frame(width: 80, height: 80)
                                        .overlay(
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 40))
                                                .foregroundStyle(Palette.mint)
                                        )

                                    Text("Customer Found")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(scannedCustomer ?? "")
                                        .font(.title3.weight(.bold))
                                        .foregroundStyle(.white)
                                    Text("7/10 stamps • Gold Member")
                                        .font(.subheadline)
                                        .foregroundStyle(Palette.muted)
                                }

                                // Stamp control
                                VStack(spacing: 12) {
                                    Text("Stamps to add")
                                        .font(.subheadline)
                                        .foregroundStyle(Palette.muted)

                                    HStack(spacing: 20) {
                                        Button {
                                            if pointsToAdd > 1 { pointsToAdd -= 1 }
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title)
                                                .foregroundStyle(Palette.muted)
                                        }

                                        Text("\(pointsToAdd)")
                                            .font(.system(size: 48, weight: .bold, design: .rounded))
                                            .foregroundStyle(.white)
                                            .frame(width: 80)

                                        Button {
                                            pointsToAdd += 1
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.title)
                                                .foregroundStyle(Palette.mint)
                                        }
                                    }
                                }
                                .padding()
                                .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)

                                HStack(spacing: 12) {
                                    Button {
                                        scannedCustomer = nil
                                        pointsToAdd = 1
                                    } label: {
                                        Text("Add Stamp")
                                            .font(.headline.weight(.semibold))
                                            .foregroundStyle(.white)
                                            .padding(.vertical, 16)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing),
                                                in: RoundedRectangle(cornerRadius: 14)
                                            )
                                            .shadow(color: Palette.mint.opacity(0.2), radius: 8, y: 4)
                                    }

                                    Button {
                                        scannedCustomer = nil
                                    } label: {
                                        Text("Redeem")
                                            .font(.headline.weight(.semibold))
                                            .foregroundStyle(.white)
                                            .padding(.vertical, 16)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                LinearGradient(colors: [Palette.goldAccent, Color(hex: "F5A623")], startPoint: .leading, endPoint: .trailing),
                                                in: RoundedRectangle(cornerRadius: 14)
                                            )
                                    }
                                }

                                Button {
                                    scannedCustomer = nil
                                    pointsToAdd = 1
                                } label: {
                                    Text("Scan Another")
                                        .font(.subheadline)
                                        .foregroundStyle(Palette.muted)
                                }
                            }
                        }
                    }
                    .padding(24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Scanner")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(Palette.mint)
                }
            }
        }
    }
}

// MARK: - Create Program View

private struct CreateProgramView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var programName = ""
    @State private var selectedType: ProgramType = .stamp
    @State private var stampCount: Int = 10
    @State private var rewardDescription = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Palette.midnight, Palette.midnightSoft], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Program name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Program Name")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                            TextField("e.g. Coffee Loyalty Card", text: $programName)
                                .padding(14)
                                .glassCard(cornerRadius: 12, opacity: 0.06, strokeOpacity: 0.10)
                                .foregroundStyle(.white)
                        }

                        // Program type
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Program Type")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)

                            ForEach(ProgramType.allCases) { type in
                                Button {
                                    selectedType = type
                                } label: {
                                    HStack(spacing: 14) {
                                        Image(systemName: type.icon)
                                            .foregroundStyle(selectedType == type ? Palette.mint : Palette.muted)
                                            .frame(width: 24)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(type.title)
                                                .font(.subheadline.weight(.semibold))
                                                .foregroundStyle(.white)
                                            Text(type.description)
                                                .font(.caption)
                                                .foregroundStyle(Palette.muted)
                                        }
                                        Spacer()
                                        if selectedType == type {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(Palette.mint)
                                        }
                                    }
                                    .padding(14)
                                    .background(
                                        selectedType == type ? Palette.mint.opacity(0.08) : Color.white.opacity(0.04),
                                        in: RoundedRectangle(cornerRadius: 14)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(selectedType == type ? Palette.mint.opacity(0.25) : Color.white.opacity(0.06))
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        // Stamp count (for stamp type)
                        if selectedType == .stamp {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stamps Required")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white)
                                Stepper(value: $stampCount, in: 3...20) {
                                    Text("\(stampCount) stamps to earn reward")
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(14)
                            .glassCard(cornerRadius: 12, opacity: 0.06, strokeOpacity: 0.08)
                        }

                        // Reward
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Reward")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                            TextField("e.g. Free coffee", text: $rewardDescription)
                                .padding(14)
                                .glassCard(cornerRadius: 12, opacity: 0.06, strokeOpacity: 0.10)
                                .foregroundStyle(.white)
                        }

                        // Create button
                        Button {
                            dismiss()
                        } label: {
                            Text("Create Program")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(.white)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .leading, endPoint: .trailing),
                                    in: RoundedRectangle(cornerRadius: 14)
                                )
                                .shadow(color: Palette.mint.opacity(0.2), radius: 8, y: 4)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 8)
                    }
                    .padding(24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("New Program")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Palette.muted)
                }
            }
        }
    }
}

private enum ProgramType: String, CaseIterable, Identifiable {
    case stamp, points, tier, referral
    var id: String { rawValue }

    var title: String {
        switch self {
        case .stamp: return "Stamp Card"
        case .points: return "Points per Dollar"
        case .tier: return "VIP Tiers"
        case .referral: return "Referral Program"
        }
    }

    var description: String {
        switch self {
        case .stamp: return "Classic punch card - earn stamps per visit"
        case .points: return "Accumulate points based on spend amount"
        case .tier: return "Multi-level membership with escalating benefits"
        case .referral: return "Reward customers for bringing friends"
        }
    }

    var icon: String {
        switch self {
        case .stamp: return "seal.fill"
        case .points: return "star.circle.fill"
        case .tier: return "crown.fill"
        case .referral: return "person.2.fill"
        }
    }
}

// MARK: - Merchant Tab Bar (with raised scanner)

private struct MerchantTabBar: View {
    @Binding var selectedTab: MerchantTab
    @Binding var showScanner: Bool

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(MerchantTab.allCases) { tab in
                    if tab == .scan {
                        Color.clear
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                    } else {
                        Button {
                            selectedTab = tab
                        } label: {
                            VStack(spacing: 5) {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 20, weight: selectedTab == tab ? .bold : .semibold))
                                Text(tab.label)
                                    .font(.system(size: 10, weight: .medium))
                            }
                            .foregroundStyle(selectedTab == tab ? .white : Palette.muted)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 18)
            .padding(.bottom, 28)
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.10), Color.white.opacity(0.04)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    )
            )
            .padding(.horizontal, 12)

            // Raised scan button with glow
            Button {
                showScanner = true
            } label: {
                ZStack {
                    Circle()
                        .fill(Palette.mint.opacity(0.15))
                        .frame(width: 80, height: 80)
                        .blur(radius: 8)

                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Palette.mint, Color(hex: "7C3AED")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 68, height: 68)
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
                        .shadow(color: Palette.mint.opacity(0.35), radius: 14, y: 4)

                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .offset(y: -34)
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Merchant Tab Enum

private enum MerchantTab: String, CaseIterable, Identifiable {
    case dashboard, programs, scan, customers, settings
    var id: String { rawValue }

    var icon: String {
        switch self {
        case .dashboard: return "square.grid.2x2.fill"
        case .programs: return "creditcard.fill"
        case .scan: return "qrcode.viewfinder"
        case .customers: return "person.2.fill"
        case .settings: return "gearshape.fill"
        }
    }

    var label: String {
        switch self {
        case .dashboard: return "Home"
        case .programs: return "Programs"
        case .scan: return "Scan"
        case .customers: return "Members"
        case .settings: return "Settings"
        }
    }
}

// MARK: - Preview

struct MerchantHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MerchantHomeView()
                .environmentObject(SessionViewModel())
        }
    }
}
