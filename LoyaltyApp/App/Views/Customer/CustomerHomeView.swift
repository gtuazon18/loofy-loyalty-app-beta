import SwiftUI

// MARK: - Merchant Data Model

struct MerchantInfo: Identifiable {
    let id = UUID()
    let name: String
    let stampCount: Int
    let totalStamps: Int
    let reward: String
    let color: Color
    let colorSecondary: Color
    let category: String
    let address: String
    let phone: String
    let website: String
    let facebook: String
    let instagram: String
    let tiktok: String
    let hours: String
    let description: String
    let balance: String
    let expiryDate: String
    let lastTransaction: String
    let icon: String
}

private let allMerchants: [MerchantInfo] = [
    MerchantInfo(
        name: "Bean & Brew Coffee",
        stampCount: 7, totalStamps: 10,
        reward: "Free Large Coffee",
        color: Color(hex: "1B3A2D"),
        colorSecondary: Color(hex: "2D5A3F"),
        category: "Cafe",
        address: "123 Market Street",
        phone: "+1 (555) 234-5678",
        website: "beanandbrewcoffee.com",
        facebook: "beanandbrewcoffee",
        instagram: "@beanandbrewcoffee",
        tiktok: "@beanandbrewcoffee",
        hours: "Mon–Fri 6am–8pm, Sat–Sun 7am–6pm",
        description: "Locally roasted specialty coffee with freshly baked pastries. Earn a stamp with every drink purchase!",
        balance: "452.31",
        expiryDate: "20 June 2026",
        lastTransaction: "12 April 2025, 12:45 PM",
        icon: "cup.and.saucer.fill"
    ),
    MerchantInfo(
        name: "Fresh Cuts Salon",
        stampCount: 3, totalStamps: 6,
        reward: "50% Off Haircut",
        color: Color(hex: "1A1A2E"),
        colorSecondary: Color(hex: "2D2D44"),
        category: "Beauty",
        address: "456 Oak Avenue",
        phone: "+1 (555) 345-6789",
        website: "freshcutssalon.com",
        facebook: "freshcutssalon",
        instagram: "@freshcutssalon",
        tiktok: "@freshcuts",
        hours: "Tue–Sat 9am–7pm",
        description: "Premium hair styling and grooming services. Collect stamps for every appointment booked!",
        balance: "2,106.10",
        expiryDate: "20 June 2026",
        lastTransaction: "12 April 2025, 12:45 PM",
        icon: "scissors"
    ),
    MerchantInfo(
        name: "Zen Yoga Studio",
        stampCount: 12, totalStamps: 15,
        reward: "1 Free Class",
        color: Color(hex: "C4B5FD"),
        colorSecondary: Color(hex: "A78BFA"),
        category: "Fitness",
        address: "789 Elm Boulevard",
        phone: "+1 (555) 456-7890",
        website: "zenyogastudio.com",
        facebook: "zenyogastudio",
        instagram: "@zenyogastudio",
        tiktok: "@zenyoga",
        hours: "Daily 6am–9pm",
        description: "Find your inner peace with our expert-led yoga, pilates, and meditation classes.",
        balance: "890.00",
        expiryDate: "15 Sept 2026",
        lastTransaction: "8 April 2025, 3:20 PM",
        icon: "figure.mind.and.body"
    ),
    MerchantInfo(
        name: "PCA Carwash",
        stampCount: 4, totalStamps: 8,
        reward: "Free Premium Wash",
        color: Color(hex: "3B82F6"),
        colorSecondary: Color(hex: "2563EB"),
        category: "Auto Care",
        address: "101 Highway Drive",
        phone: "+1 (555) 567-8901",
        website: "pcacarwash.com",
        facebook: "pcacarwash",
        instagram: "@pcacarwash",
        tiktok: "@pcacarwash",
        hours: "Mon–Sun 7am–7pm",
        description: "Professional car wash & detailing. Eco-friendly products. Earn stamps with every wash and get a free premium wash!",
        balance: "55.23",
        expiryDate: "1 Dec 2026",
        lastTransaction: "10 April 2025, 9:10 AM",
        icon: "car.fill"
    )
]

// MARK: - Customer Home View

struct CustomerHomeView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var selectedTab: CustomerTab = .home
    @State private var showScanner = false
    @State private var selectedMerchant: MerchantInfo? = nil
    @Namespace private var cardAnimation

    var body: some View {
        ZStack(alignment: .bottom) {
            // Refined background
            ZStack {
                LinearGradient(colors: [Palette.midnight, Palette.midnightSoft], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                // Ambient glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Palette.mint.opacity(0.04), Color.clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 250
                        )
                    )
                    .frame(width: 500, height: 500)
                    .offset(x: -60, y: -150)
                    .blur(radius: 40)
            }

            TabContentView(
                selectedTab: $selectedTab,
                showScanner: $showScanner,
                selectedMerchant: $selectedMerchant,
                cardAnimation: cardAnimation,
                username: session.username
            )
            .padding(.bottom, 110)

            CustomerTabBar(selectedTab: $selectedTab, showScanner: $showScanner)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack(spacing: 10) {
                    // Avatar with glow
                    ZStack {
                        Circle()
                            .fill(Palette.mint.opacity(0.15))
                            .frame(width: 40, height: 40)
                            .blur(radius: 4)

                        Circle()
                            .fill(
                                LinearGradient(colors: [Palette.mint, Color(hex: "7C3AED")], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 34, height: 34)
                            .overlay(
                                Text(String(session.username.prefix(1)))
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(.white)
                            )
                    }

                    VStack(alignment: .leading, spacing: 1) {
                        Text("Hi, \(session.username.components(separatedBy: " ").first ?? session.username)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text("Loofy")
                            .font(.caption2.weight(.medium))
                            .foregroundStyle(Palette.muted)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Image(systemName: "bell.badge")
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    Button(action: { session.signOut() }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }
            }
        }
        .sheet(isPresented: $showScanner) {
            CustomerQRView()
                .environmentObject(session)
        }
        .sheet(item: $selectedMerchant) { merchant in
            MerchantDetailView(merchant: merchant)
        }
    }
}

// MARK: - Tab Content Router

private struct TabContentView: View {
    @Binding var selectedTab: CustomerTab
    @Binding var showScanner: Bool
    @Binding var selectedMerchant: MerchantInfo?
    var cardAnimation: Namespace.ID
    let username: String

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                switch selectedTab {
                case .home:
                    HomeContent(username: username, selectedMerchant: $selectedMerchant)
                case .cards:
                    CardsContent(selectedMerchant: $selectedMerchant, cardAnimation: cardAnimation)
                case .scan:
                    EmptyView()
                case .rewards:
                    RewardsContent()
                case .profile:
                    CustomerProfileContent(username: username)
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 12)
        }
    }
}

// MARK: - Home Content

private struct HomeContent: View {
    let username: String
    @Binding var selectedMerchant: MerchantInfo?

    var body: some View {
        VStack(spacing: 20) {
            LoyaltyHeroCard(username: username)
            QuickActionsRow()
            ActiveProgramsSection(selectedMerchant: $selectedMerchant)
            RecentActivitySection()
        }
    }
}

private struct LoyaltyHeroCard: View {
    let username: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Palette.gold)
                .overlay(
                    // Glass-like inner highlight
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [.white.opacity(0.2), .clear],
                                startPoint: .topLeading,
                                endPoint: .center
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.25), lineWidth: 0.8)
                )
                .shadow(color: Palette.goldAccent.opacity(0.25), radius: 24, y: 14)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 6) {
                        Image(systemName: "crown.fill")
                            .foregroundStyle(Palette.midnightSoft)
                            .font(.caption)
                        Text("GOLD MEMBER")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(Palette.midnightSoft)
                            .tracking(1.2)
                    }

                    Text("8,240 pts")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Palette.midnightSoft)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("760 more to Platinum")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(Palette.midnightSoft.opacity(0.8))
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.35))
                                    .frame(height: 8)
                                Capsule()
                                    .fill(Palette.midnightSoft)
                                    .frame(width: geo.size.width * 0.82, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                }

                Spacer()

                VStack(spacing: 10) {
                    Image(systemName: "seal.fill")
                        .foregroundStyle(Palette.midnightSoft.opacity(0.25))
                        .font(.system(size: 52))
                    Text("S2")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Palette.midnightSoft.opacity(0.5))
                }
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 185)
    }
}

private struct QuickActionsRow: View {
    private let actions: [(icon: String, label: String, color: Color)] = [
        ("qrcode.viewfinder", "Scan", Palette.mint),
        ("gift", "Rewards", Palette.goldAccent),
        ("arrow.left.arrow.right", "Transfer", Palette.sky),
        ("clock.arrow.circlepath", "History", Palette.lavender)
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(actions, id: \.label) { action in
                Button(action: {}) {
                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(action.color.opacity(0.12))
                                .frame(width: 54, height: 54)
                            Image(systemName: action.icon)
                                .font(.title3)
                                .foregroundStyle(action.color)
                        }
                        Text(action.label)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct ActiveProgramsSection: View {
    @Binding var selectedMerchant: MerchantInfo?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("My Loyalty Cards")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Button("See All") {}
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Palette.mint)
            }

            ForEach(allMerchants) { merchant in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedMerchant = merchant
                    }
                } label: {
                    HStack(spacing: 14) {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(merchant.color)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Text(String(merchant.name.prefix(1)))
                                    .font(.title3.weight(.bold))
                                    .foregroundStyle(.white)
                            )
                            .shadow(color: merchant.color.opacity(0.3), radius: 6, y: 2)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(merchant.name)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("\(merchant.stampCount)/\(merchant.totalStamps) stamps")
                                .font(.caption)
                                .foregroundStyle(Palette.muted)
                        }

                        Spacer()

                        HStack(spacing: 3) {
                            ForEach(0..<merchant.totalStamps, id: \.self) { i in
                                Circle()
                                    .fill(i < merchant.stampCount ? Palette.mint : Color.white.opacity(0.12))
                                    .frame(width: 8, height: 8)
                            }
                        }

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(Color.white.opacity(0.25))
                    }
                    .padding(14)
                    .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                }
                .buttonStyle(CardPressStyle())
            }
        }
    }
}

// MARK: - Card Press Animation Style

private struct CardPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

private struct RecentActivitySection: View {
    private let activities: [(icon: String, title: String, detail: String, time: String, color: Color)] = [
        ("plus.circle.fill", "+50 pts", "Bean & Brew Coffee", "2h ago", Palette.mint),
        ("car.fill", "+1 stamp", "PCA Carwash", "Yesterday", Palette.sky),
        ("gift.fill", "Free drink redeemed", "Bean & Brew Coffee", "2 days ago", Palette.goldAccent),
        ("star.fill", "New stamp earned", "Fresh Cuts Salon", "3 days ago", Palette.lavender)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recent Activity")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            ForEach(activities, id: \.title) { activity in
                HStack(spacing: 12) {
                    Image(systemName: activity.icon)
                        .font(.title3)
                        .foregroundStyle(activity.color)
                        .frame(width: 36)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(activity.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text(activity.detail)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    Text(activity.time)
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

// MARK: - Cards Content

private struct CardsContent: View {
    @Binding var selectedMerchant: MerchantInfo?
    var cardAnimation: Namespace.ID

    var body: some View {
        VStack(spacing: 20) {
            ForEach(allMerchants) { merchant in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedMerchant = merchant
                    }
                } label: {
                    LoyaltyCardView(merchant: merchant)
                }
                .buttonStyle(CardPressStyle())
            }
        }
    }
}

private struct LoyaltyCardView: View {
    let merchant: MerchantInfo

    var body: some View {
        ZStack(alignment: .leading) {
            // Card background with refined gradient
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [merchant.color, merchant.colorSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Glass-like highlight on top edge
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.12), .clear],
                        startPoint: .top,
                        endPoint: .center
                    )
                )

            // Decorative background circles — softer
            Circle()
                .fill(Color.white.opacity(0.04))
                .frame(width: 200, height: 200)
                .offset(x: 150, y: 50)

            Circle()
                .fill(Color.white.opacity(0.03))
                .frame(width: 130, height: 130)
                .offset(x: 210, y: -30)

            // Card content
            VStack(alignment: .leading, spacing: 0) {
                // Top row: logo + name + expiry
                HStack(alignment: .top) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 46, height: 46)
                        Image(systemName: merchant.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(.white.opacity(0.9))
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(merchant.name)
                            .font(.headline.weight(.bold))
                            .foregroundStyle(.white)
                        Text("Expires \(merchant.expiryDate)")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.55))
                    }

                    Spacer()
                }

                Spacer()

                // Balance
                VStack(alignment: .leading, spacing: 4) {
                    Text("Balance")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                    Text("$\(merchant.balance)")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }

                Spacer()

                // Bottom row: last transaction + arrow
                HStack {
                    Text("Last Transaction: \(merchant.lastTransaction)")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.45))

                    Spacer()

                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 34, height: 34)
                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
            }
            .padding(20)
        }
        .frame(height: 195)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
        )
        .shadow(color: merchant.color.opacity(0.25), radius: 16, y: 8)
    }
}

// MARK: - Merchant Detail View (Sheet with social links)

struct MerchantDetailView: View {
    let merchant: MerchantInfo
    @Environment(\.dismiss) private var dismiss
    @State private var appeared = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Palette.midnight, Palette.midnightSoft], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Hero header
                    ZStack {
                        merchant.color.opacity(0.15)

                        // Ambient glow
                        Circle()
                            .fill(merchant.color.opacity(0.2))
                            .frame(width: 200, height: 200)
                            .blur(radius: 60)
                            .offset(y: -20)

                        VStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .fill(merchant.color)
                                .frame(width: 84, height: 84)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                                        .fill(
                                            LinearGradient(
                                                colors: [.white.opacity(0.2), .clear],
                                                startPoint: .topLeading,
                                                endPoint: .center
                                            )
                                        )
                                )
                                .overlay(
                                    Text(String(merchant.name.prefix(1)))
                                        .font(.largeTitle.weight(.bold))
                                        .foregroundStyle(.white)
                                )
                                .shadow(color: merchant.color.opacity(0.4), radius: 20, y: 8)
                                .scaleEffect(appeared ? 1.0 : 0.5)
                                .opacity(appeared ? 1.0 : 0)

                            Text(merchant.name)
                                .font(.title2.weight(.bold))
                                .foregroundStyle(.white)
                                .opacity(appeared ? 1.0 : 0)
                                .offset(y: appeared ? 0 : 10)

                            Text(merchant.category)
                                .font(.subheadline)
                                .foregroundStyle(Palette.muted)
                                .opacity(appeared ? 1.0 : 0)
                        }
                        .padding(.vertical, 30)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 0))

                    VStack(spacing: 20) {
                        // Stamp progress
                        VStack(spacing: 12) {
                            HStack {
                                Text("Stamp Progress")
                                    .font(.headline.weight(.semibold))
                                    .foregroundStyle(.white)
                                Spacer()
                                Text("\(merchant.stampCount)/\(merchant.totalStamps)")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(merchant.color)
                            }

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.white.opacity(0.08))
                                        .frame(height: 10)
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [merchant.color, merchant.colorSecondary],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: appeared ? geo.size.width * CGFloat(merchant.stampCount) / CGFloat(merchant.totalStamps) : 0, height: 10)
                                }
                            }
                            .frame(height: 10)

                            Text("Reward: \(merchant.reward)")
                                .font(.subheadline)
                                .foregroundStyle(Palette.goldAccent)
                        }
                        .padding(16)
                        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)

                        // About
                        VStack(alignment: .leading, spacing: 10) {
                            Text("About")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(.white)
                            Text(merchant.description)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.75))
                                .lineSpacing(4)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 25)

                        // Contact info
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Contact")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(.white)

                            ContactRow(icon: "mappin.circle.fill", label: merchant.address, color: Palette.rose)
                            ContactRow(icon: "phone.circle.fill", label: merchant.phone, color: Palette.lime)
                            ContactRow(icon: "globe", label: merchant.website, color: Palette.mint)
                            ContactRow(icon: "clock.fill", label: merchant.hours, color: Palette.goldAccent)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 30)

                        // Social links
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Follow Us")
                                .font(.headline.weight(.semibold))
                                .foregroundStyle(.white)

                            HStack(spacing: 14) {
                                SocialButton(icon: "f.square.fill", label: "Facebook", handle: merchant.facebook, color: Color(hex: "1877F2"))
                                SocialButton(icon: "camera.circle.fill", label: "Instagram", handle: merchant.instagram, color: Color(hex: "E4405F"))
                                SocialButton(icon: "play.rectangle.fill", label: "TikTok", handle: merchant.tiktok, color: .white)
                            }
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 35)

                        // Action buttons
                        HStack(spacing: 12) {
                            Button(action: {}) {
                                Label("Get Directions", systemImage: "map.fill")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 14)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(
                                            colors: [Palette.mint, Color(hex: "7C3AED")],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        in: RoundedRectangle(cornerRadius: 14)
                                    )
                                    .shadow(color: Palette.mint.opacity(0.2), radius: 8, y: 4)
                            }

                            Button(action: {}) {
                                Label("Share", systemImage: "square.and.arrow.up")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 14)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
                                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.10)))
                            }
                        }
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 40)
                    }
                    .padding(20)
                }
            }

            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Palette.muted)
                            .padding(16)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1)) {
                appeared = true
            }
        }
    }
}

private struct ContactRow: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
        }
    }
}

private struct SocialButton: View {
    let icon: String
    let label: String
    let handle: String
    let color: Color

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Palette.muted)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.06)))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Rewards Content

private struct RewardsContent: View {
    private let rewards: [(title: String, merchant: String, points: String, icon: String, color: Color)] = [
        ("Free Large Coffee", "Bean & Brew", "100 pts", "cup.and.saucer.fill", Color(hex: "1B3A2D")),
        ("50% Off Haircut", "Fresh Cuts", "200 pts", "scissors", Color(hex: "1A1A2E")),
        ("Free Yoga Class", "Zen Yoga", "150 pts", "figure.mind.and.body", Palette.lavender),
        ("Free Premium Wash", "PCA Carwash", "80 pts", "car.fill", Palette.sky),
        ("$10 Gift Card", "Partner Store", "500 pts", "giftcard.fill", Palette.goldAccent)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Available Rewards")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            ForEach(rewards, id: \.title) { reward in
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(reward.color.opacity(0.15))
                            .frame(width: 48, height: 48)
                        Image(systemName: reward.icon)
                            .foregroundStyle(reward.color)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(reward.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                        Text(reward.merchant)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    Button(action: {}) {
                        Text(reward.points)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                LinearGradient(
                                    colors: [Palette.mint, Color(hex: "7C3AED")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                in: Capsule()
                            )
                    }
                }
                .padding(14)
                .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
            }
        }
    }
}

// MARK: - Customer Profile (with Appearance Picker)

private struct CustomerProfileContent: View {
    let username: String
    @EnvironmentObject private var session: SessionViewModel

    var body: some View {
        VStack(spacing: 18) {
            // Profile header
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Palette.mint.opacity(0.1))
                        .frame(width: 96, height: 96)
                        .blur(radius: 8)

                    Circle()
                        .fill(Palette.gold)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.white.opacity(0.2), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .center
                                    )
                                )
                                .padding(2)
                        )
                        .overlay(
                            Text(String(username.prefix(1)))
                                .font(.title.weight(.bold))
                                .foregroundStyle(Palette.midnightSoft)
                        )
                        .shadow(color: Palette.goldAccent.opacity(0.25), radius: 12, y: 4)
                }

                Text(username)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                Text("Gold Member • 8,240 pts")
                    .font(.subheadline)
                    .foregroundStyle(Palette.muted)
            }
            .padding(.vertical, 8)

            // Stats
            HStack(spacing: 0) {
                ProfileStat(value: "4", label: "Cards")
                ProfileStat(value: "26", label: "Stamps")
                ProfileStat(value: "5", label: "Rewards")
            }
            .padding()
            .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)

            // Appearance picker
            VStack(alignment: .leading, spacing: 12) {
                Text("Appearance")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.white)

                HStack(spacing: 10) {
                    ForEach(AppAppearance.allCases) { mode in
                        let selected = session.appearance == mode
                        Button {
                            session.setAppearance(mode)
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: mode.icon)
                                    .font(.title3)
                                    .foregroundStyle(selected ? Palette.mint : Palette.muted)
                                Text(mode.label)
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(selected ? .white : Palette.muted)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                selected ? Palette.mint.opacity(0.12) : Color.white.opacity(0.04),
                                in: RoundedRectangle(cornerRadius: 14)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(selected ? Palette.mint.opacity(0.35) : Color.white.opacity(0.06))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(16)
            .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)

            // Menu items
            VStack(spacing: 0) {
                ProfileMenuItem(icon: "person.circle", title: "Edit Profile")
                ProfileMenuItem(icon: "bell", title: "Notifications")
                ProfileMenuItem(icon: "wallet.pass", title: "Add to Wallet")
                ProfileMenuItem(icon: "gearshape", title: "Settings")
                ProfileMenuItem(icon: "questionmark.circle", title: "Help & Support")
            }
            .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
        }
    }
}

private struct ProfileStat: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
            Text(label)
                .font(.caption)
                .foregroundStyle(Palette.muted)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct ProfileMenuItem: View {
    let icon: String
    let title: String

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 14) {
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
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Customer QR View

struct CustomerQRView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var session: SessionViewModel

    var body: some View {
        ZStack {
            LinearGradient(colors: [Palette.midnight, Palette.midnightSoft], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            // Ambient glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Palette.mint.opacity(0.06), Color.clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 180
                    )
                )
                .frame(width: 360, height: 360)
                .blur(radius: 30)

            VStack(spacing: 24) {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Palette.muted)
                    }
                }

                Spacer()

                Text("Show this to the cashier")
                    .font(.headline)
                    .foregroundStyle(.white)

                QRCodeView(
                    data: "LOOFY-\(session.username.uppercased().replacingOccurrences(of: " ", with: "-"))-8240",
                    size: 220
                )
                .shadow(color: .white.opacity(0.1), radius: 24)

                Text(session.username.uppercased().replacingOccurrences(of: " ", with: "-") + "-8240")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Palette.muted)
                    .tracking(2)

                Text("8,240 Points")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Palette.goldAccent)

                Spacer()

                Button(action: {}) {
                    Label("Add to Apple Wallet", systemImage: "wallet.pass.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black, in: RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(24)
        }
    }
}

// MARK: - Customer Tab Bar (Larger QR Scanner)

private struct CustomerTabBar: View {
    @Binding var selectedTab: CustomerTab
    @Binding var showScanner: Bool

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(CustomerTab.allCases) { tab in
                    if tab == .scan {
                        Color.clear
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                    } else {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedTab = tab
                            }
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
                    // Outer glow
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

// MARK: - Customer Tab Enum

enum CustomerTab: String, CaseIterable, Identifiable {
    case home, cards, scan, rewards, profile
    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .cards: return "creditcard.fill"
        case .scan: return "qrcode.viewfinder"
        case .rewards: return "gift.fill"
        case .profile: return "person.crop.circle"
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .cards: return "Cards"
        case .scan: return "Scan"
        case .rewards: return "Rewards"
        case .profile: return "Profile"
        }
    }
}

// MARK: - Preview

struct CustomerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerHomeView()
                .environmentObject(SessionViewModel())
        }
    }
}
