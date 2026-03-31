import SwiftUI

// MARK: - Merchant Data Model

enum MerchantLogoType {
    case sfSymbol(String)
    case starbucks
    case mcdonalds
    case pca
}

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
    var logoType: MerchantLogoType = .sfSymbol("")

    init(name: String, stampCount: Int, totalStamps: Int, reward: String, color: Color, colorSecondary: Color, category: String, address: String, phone: String, website: String, facebook: String, instagram: String, tiktok: String, hours: String, description: String, balance: String, expiryDate: String, lastTransaction: String, icon: String, logoType: MerchantLogoType? = nil) {
        self.name = name
        self.stampCount = stampCount
        self.totalStamps = totalStamps
        self.reward = reward
        self.color = color
        self.colorSecondary = colorSecondary
        self.category = category
        self.address = address
        self.phone = phone
        self.website = website
        self.facebook = facebook
        self.instagram = instagram
        self.tiktok = tiktok
        self.hours = hours
        self.description = description
        self.balance = balance
        self.expiryDate = expiryDate
        self.lastTransaction = lastTransaction
        self.icon = icon
        self.logoType = logoType ?? .sfSymbol(icon)
    }
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
        icon: "car.fill",
        logoType: .pca
    ),
    MerchantInfo(
        name: "Starbucks",
        stampCount: 9, totalStamps: 12,
        reward: "Free Handcrafted Drink",
        color: Color(hex: "00704A"),
        colorSecondary: Color(hex: "1E3932"),
        category: "Coffee",
        address: "200 Pike Place",
        phone: "+1 (555) 678-9012",
        website: "starbucks.com",
        facebook: "starbucks",
        instagram: "@starbucks",
        tiktok: "@starbucks",
        hours: "Mon–Sun 5am–10pm",
        description: "Premium coffee, handcrafted beverages, and fresh food. Earn stars with every purchase and unlock exclusive rewards!",
        balance: "1,230.50",
        expiryDate: "31 Dec 2026",
        lastTransaction: "22 March 2026, 8:15 AM",
        icon: "cup.and.saucer.fill",
        logoType: .starbucks
    ),
    MerchantInfo(
        name: "McDonald's",
        stampCount: 5, totalStamps: 8,
        reward: "Free Big Mac Meal",
        color: Color(hex: "DA291C"),
        colorSecondary: Color(hex: "FFC72C"),
        category: "Fast Food",
        address: "500 Golden Arches Blvd",
        phone: "+1 (555) 789-0123",
        website: "mcdonalds.com",
        facebook: "mcdonalds",
        instagram: "@mcdonalds",
        tiktok: "@mcdonalds",
        hours: "Mon–Sun 6am–12am",
        description: "Iconic fast food with burgers, fries, and more. Collect stamps with every meal and earn free menu items!",
        balance: "340.75",
        expiryDate: "15 Nov 2026",
        lastTransaction: "21 March 2026, 12:30 PM",
        icon: "fork.knife",
        logoType: .mcdonalds
    )
]

// MARK: - Customer Home View

struct CustomerHomeView: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var selectedTab: CustomerTab = .home
    @State private var showScanner = false
    @State private var showNotifications = false
    @State private var selectedMerchant: MerchantInfo? = nil
    @Namespace private var cardAnimation

    var body: some View {
        VStack(spacing: 0) {
            // Custom header bar
            HStack(spacing: 10) {
                // Avatar
                Circle()
                    .fill(Color(hex: "1A1A1A"))
                    .frame(width: 38, height: 38)
                    .overlay(
                        Text(String(session.username.prefix(1)))
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white)
                    )

                VStack(alignment: .leading, spacing: 1) {
                    Text("Hi \(session.username.components(separatedBy: " ").first ?? session.username) 👋")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text("Welcome back")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(Palette.muted)
                }

                Spacer()

                Button { showNotifications = true } label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell")
                            .font(.title3)
                            .foregroundStyle(Palette.textPrimary)
                        if session.unreadCount > 0 {
                            Text("\(session.unreadCount)")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 16, height: 16)
                                .background(Color(hex: "E8455E"), in: Circle())
                                .offset(x: 6, y: -6)
                        }
                    }
                }

                Button(action: { session.signOut() }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title3)
                        .foregroundStyle(Palette.textPrimary)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)

            ZStack(alignment: .bottom) {
                // Refined background
                Color.white
                    .ignoresSafeArea()

                TabContentView(
                    selectedTab: $selectedTab,
                    showScanner: $showScanner,
                    selectedMerchant: $selectedMerchant,
                    cardAnimation: cardAnimation,
                    username: session.username
                )

                CustomerTabBar(selectedTab: $selectedTab, showScanner: $showScanner)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showScanner) {
            CustomerQRView()
                .environmentObject(session)
        }
        .sheet(item: $selectedMerchant) { merchant in
            MerchantDetailView(merchant: merchant)
        }
        .sheet(isPresented: $showNotifications) {
            NotificationsSheet()
                .environmentObject(session)
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
            VStack(spacing: 14) {
                switch selectedTab {
                case .home:
                    HomeContent(username: username, selectedMerchant: $selectedMerchant, selectedTab: $selectedTab)
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
            .padding(18)
            .padding(.bottom, 90)
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - Home Content

private struct HomeContent: View {
    let username: String
    @Binding var selectedMerchant: MerchantInfo?
    @Binding var selectedTab: CustomerTab

    var body: some View {
        VStack(spacing: 14) {
            LoyaltyHeroCard(username: username)
            QuickActionsRow()
            ActiveProgramsSection(selectedMerchant: $selectedMerchant, onSeeAll: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = .cards
                }
            })
            RecentActivitySection()
        }
    }
}

private struct LoyaltyHeroCard: View {
    let username: String
    @EnvironmentObject private var session: SessionViewModel

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
                        .stroke(Color.black.opacity(0.06), lineWidth: 0.8)
                )
                .shadow(color: Palette.goldAccent.opacity(0.15), radius: 24, y: 14)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total Points")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color(hex: "1A1A1A").opacity(0.6))
                        .tracking(0.8)

                    Text("\(session.totalPoints.formatted()) pts")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(hex: "1A1A1A"))
                        .contentTransition(.numericText())

                    VStack(alignment: .leading, spacing: 6) {
                        Text("760 more to Platinum")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(Color(hex: "1A1A1A").opacity(0.7))
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.35))
                                    .frame(height: 8)
                                Capsule()
                                    .fill(Color(hex: "1A1A1A"))
                                    .frame(width: geo.size.width * 0.82, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                }

                Spacer()

                VStack(spacing: 10) {
                    Image(systemName: "seal.fill")
                        .foregroundStyle(Color(hex: "1A1A1A").opacity(0.15))
                        .font(.system(size: 52))
                    Text("S2")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color(hex: "1A1A1A").opacity(0.4))
                }
            }
            .padding(18)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 155)
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
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(action.color.opacity(0.12))
                                .frame(width: 46, height: 46)
                            Image(systemName: action.icon)
                                .font(.body)
                                .foregroundStyle(action.color)
                        }
                        Text(action.label)
                            .font(.caption2)
                            .foregroundStyle(Palette.textPrimary)
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
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("My Loyalty Cards")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                Spacer()
                Button("See All") { onSeeAll?() }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Palette.textSecondary)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(allMerchants) { merchant in
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                selectedMerchant = merchant
                            }
                        } label: {
                            VStack(spacing: 8) {
                                MerchantThumbnail(merchant: merchant, size: 56)
                                    .clipShape(Circle())

                                Text(merchant.name.split(separator: " ").first.map(String.init) ?? merchant.name)
                                    .font(.caption2.weight(.medium))
                                    .foregroundStyle(Palette.textPrimary)
                                    .lineLimit(1)

                                Text("Value $\(merchant.balance)")
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(Palette.muted)
                                    .lineLimit(1)
                            }
                            .frame(width: 70)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}

// MARK: - Merchant Thumbnail (brand logo or letter)

private struct MerchantThumbnail: View {
    let merchant: MerchantInfo
    var size: CGFloat = 48

    var body: some View {
        switch merchant.logoType {
        case .starbucks:
            StarbucksLogo(size: size)
        case .mcdonalds:
            McDonaldsLogo(size: size)
        case .pca:
            PCALogo(size: size)
        case .sfSymbol:
            Circle()
                .fill(merchant.color)
                .frame(width: size, height: size)
                .overlay(
                    Text(String(merchant.name.prefix(1)))
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundStyle(.white)
                )
                .shadow(color: merchant.color.opacity(0.3), radius: 6, y: 2)
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
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activity")
                .font(.headline.weight(.semibold))
                .foregroundStyle(Palette.textPrimary)

            ForEach(activities, id: \.title) { activity in
                HStack(spacing: 10) {
                    Image(systemName: activity.icon)
                        .font(.body)
                        .foregroundStyle(activity.color)
                        .frame(width: 28)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(activity.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Palette.textPrimary)
                        Text(activity.detail)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    Text(activity.time)
                        .font(.caption)
                        .foregroundStyle(Palette.muted)
                }
                .padding(.vertical, 2)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16, opacity: 0.05, strokeOpacity: 0.08)
    }
}

// MARK: - Cards Content

private struct CardsContent: View {
    @Binding var selectedMerchant: MerchantInfo?
    var cardAnimation: Namespace.ID

    var body: some View {
        VStack(spacing: 16) {
            ForEach(allMerchants) { merchant in
                LoyaltyCardView(merchant: merchant) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        selectedMerchant = merchant
                    }
                }
            }
        }
    }
}

// MARK: - Loyalty Card View (Branded card with balance & details)

private struct LoyaltyCardView: View {
    let merchant: MerchantInfo
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .leading) {
                // Solid opaque card background
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [merchant.color, merchant.colorSecondary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                // Decorative circles
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.clear)
                    .overlay {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 140, height: 140)
                            .offset(x: 120, y: -30)
                        Circle()
                            .fill(Color.white.opacity(0.06))
                            .frame(width: 100, height: 100)
                            .offset(x: 140, y: 40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                // Card content — white text on solid color
                VStack(alignment: .leading, spacing: 0) {
                    // Top row: Logo + Name + Expiry
                    HStack(spacing: 10) {
                        LoyaltyCardIcon(merchant: merchant)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(merchant.name)
                                .font(.subheadline.weight(.bold))
                                .foregroundStyle(.white)
                            Text("Expires \(merchant.expiryDate)")
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.7))
                        }

                        Spacer()
                    }

                    Spacer()

                    // Balance
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Balance")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(merchant.balance)
                            .font(.title.weight(.bold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    // Bottom row: Last transaction + chevron
                    HStack {
                        Text("Last Transaction: \(merchant.lastTransaction)")
                            .font(.caption2)
                            .foregroundStyle(.white.opacity(0.6))
                            .lineLimit(1)

                        Spacer()

                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
                .padding(16)
            }
            .frame(height: 165)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: merchant.color.opacity(0.3), radius: 12, y: 6)
        }
        .buttonStyle(CardPressStyle())
    }
}

// MARK: - Stamp Grid

private struct StampGrid: View {
    let stampCount: Int
    let totalStamps: Int
    let columns: Int
    let merchantColor: Color
    let stampsRevealed: [Bool]

    var body: some View {
        let rows = (totalStamps + columns - 1) / columns

        VStack(spacing: 10) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<columns, id: \.self) { col in
                        let index = row * columns + col
                        if index < totalStamps {
                            StampCircle(
                                index: index,
                                isCollected: index < stampCount,
                                isLast: index == totalStamps - 1,
                                merchantColor: merchantColor,
                                revealed: index < stampsRevealed.count && stampsRevealed[index]
                            )
                        } else {
                            Color.clear
                                .frame(width: stampSize, height: stampSize)
                        }
                    }
                }
            }
        }
    }

    private var stampSize: CGFloat { 40 }
}

// MARK: - Individual Stamp Circle

private struct StampCircle: View {
    let index: Int
    let isCollected: Bool
    let isLast: Bool
    let merchantColor: Color
    let revealed: Bool

    var body: some View {
        ZStack {
            if isCollected {
                // Collected stamp — filled with icon
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [merchantColor, merchantColor.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.white.opacity(0.25), .clear],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                )
                            )
                            .padding(1)
                    )
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Palette.textPrimary)
                    )
                    .shadow(color: merchantColor.opacity(0.3), radius: 4, y: 2)
                    .scaleEffect(revealed ? 1.0 : 0.3)
                    .opacity(revealed ? 1.0 : 0)
            } else if isLast {
                // Last stamp = reward stamp (special)
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Palette.goldAccent, Palette.goldAccent.opacity(0.5)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 2, dash: [4, 3])
                            )
                    )
                    .overlay(
                        Image(systemName: "gift.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Palette.goldAccent.opacity(0.7))
                    )
                    .scaleEffect(revealed ? 1.0 : 0.3)
                    .opacity(revealed ? 1.0 : 0)
            } else {
                // Empty stamp — dashed outline
                Circle()
                    .fill(Color.black.opacity(0.02))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.06), style: StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                    )
                    .overlay(
                        Text("\(index + 1)")
                            .font(.caption2.weight(.medium))
                            .foregroundStyle(Palette.muted)
                    )
                    .scaleEffect(revealed ? 1.0 : 0.3)
                    .opacity(revealed ? 1.0 : 0)
            }
        }
    }
}

// MARK: - Merchant Detail Hero Icon

private struct MerchantDetailHeroIcon: View {
    let merchant: MerchantInfo

    var body: some View {
        switch merchant.logoType {
        case .starbucks:
            StarbucksLogo(size: 84)
        case .mcdonalds:
            McDonaldsLogo(size: 84)
        case .pca:
            PCALogo(size: 84)
        case .sfSymbol:
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
                        .foregroundStyle(Palette.textPrimary)
                )
        }
    }
}

// MARK: - Loyalty Card Icon (brand logo or SF Symbol)

private struct LoyaltyCardIcon: View {
    let merchant: MerchantInfo

    var body: some View {
        switch merchant.logoType {
        case .starbucks:
            StarbucksLogo(size: 44)
        case .mcdonalds:
            McDonaldsLogo(size: 44)
        case .pca:
            PCALogo(size: 44)
        case .sfSymbol:
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 46, height: 46)
                Image(systemName: merchant.icon)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
        }
    }
}

// MARK: - Merchant Detail View (Sheet with social links)

struct MerchantDetailView: View {
    let merchant: MerchantInfo
    @Environment(\.dismiss) private var dismiss
    @State private var appeared = false
    @State private var stampsRevealed: [Bool]

    init(merchant: MerchantInfo) {
        self.merchant = merchant
        _stampsRevealed = State(initialValue: Array(repeating: false, count: merchant.totalStamps))
    }

    private var stampColumns: Int {
        if merchant.totalStamps <= 6 { return 3 }
        if merchant.totalStamps <= 10 { return 5 }
        return 5
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Merchant Header with Stamps
                ZStack {
                    // Merchant-colored background
                    LinearGradient(
                        colors: [merchant.color, merchant.colorSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    // Decorative circles
                    Circle()
                        .fill(Color.white.opacity(0.06))
                        .frame(width: 250, height: 250)
                        .offset(x: 100, y: -80)
                    Circle()
                        .fill(Color.white.opacity(0.04))
                        .frame(width: 180, height: 180)
                        .offset(x: -120, y: 100)

                    VStack(spacing: 0) {
                        Spacer().frame(height: 60)

                        // Logo
                        MerchantDetailHeroIcon(merchant: merchant)
                            .shadow(color: .black.opacity(0.2), radius: 12, y: 6)
                            .scaleEffect(appeared ? 1.0 : 0.5)
                            .opacity(appeared ? 1.0 : 0)

                        // Name
                        Text(merchant.name)
                            .font(.title2.weight(.bold))
                            .foregroundStyle(.white)
                            .padding(.top, 12)
                            .opacity(appeared ? 1.0 : 0)

                        // Stamp card
                        VStack(spacing: 12) {
                            StampGrid(
                                stampCount: merchant.stampCount,
                                totalStamps: merchant.totalStamps,
                                columns: stampColumns,
                                merchantColor: merchant.color,
                                stampsRevealed: stampsRevealed
                            )
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.white.opacity(0.15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 0.8)
                                )
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .opacity(appeared ? 1 : 0)
                        .offset(y: appeared ? 0 : 20)

                        // Reward text
                        Text(merchant.reward.uppercased())
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)
                            .padding(.horizontal, 24)
                            .opacity(appeared ? 1 : 0)

                        Spacer().frame(height: 28)
                    }
                }
                .clipShape(
                    UnevenRoundedRectangle(
                        bottomLeadingRadius: 28,
                        bottomTrailingRadius: 28
                    )
                )

                // MARK: - Details Section
                VStack(spacing: 20) {
                    // About
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Palette.textPrimary)
                        Text(merchant.description)
                            .font(.subheadline)
                            .foregroundStyle(Palette.textSecondary)
                            .lineSpacing(4)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)

                    // Social row
                    HStack(spacing: 14) {
                        SocialCircleButton(icon: { FacebookIcon(size: 44) })
                        SocialCircleButton(icon: { InstagramIcon(size: 44) })
                        SocialCircleButton(icon: {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(Color(hex: "34C759"), in: Circle())
                        })
                        SocialCircleButton(icon: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(Palette.goldAccent, in: Circle())
                        })
                    }
                    .frame(maxWidth: .infinity)

                    // Contact / Location
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Contact")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(Palette.textPrimary)

                        ContactRow(icon: "mappin.circle.fill", label: merchant.address, color: Palette.rose)
                        ContactRow(icon: "phone.circle.fill", label: merchant.phone, color: Palette.lime)
                        ContactRow(icon: "globe", label: merchant.website, color: Palette.mint)
                        ContactRow(icon: "clock.fill", label: merchant.hours, color: Palette.goldAccent)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)

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
                                        colors: [Color(hex: "1A1A1A"), Color(hex: "333333")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    in: RoundedRectangle(cornerRadius: 14)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 8, y: 4)
                        }

                        Button(action: {}) {
                            Label("Share", systemImage: "square.and.arrow.up")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Palette.textPrimary)
                                .padding(.vertical, 14)
                                .frame(maxWidth: .infinity)
                                .background(Color.black.opacity(0.03), in: RoundedRectangle(cornerRadius: 14))
                                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.black.opacity(0.05)))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.2), in: Circle())
            }
            .padding(.leading, 16)
            .padding(.top, 54)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1)) {
                appeared = true
            }
            for i in 0..<merchant.totalStamps {
                withAnimation(
                    .spring(response: 0.4, dampingFraction: 0.6)
                    .delay(0.3 + Double(i) * 0.06)
                ) {
                    stampsRevealed[i] = true
                }
            }
        }
    }
}

// MARK: - Social Circle Button (for expanded detail sheet)

private struct SocialCircleButton<Icon: View>: View {
    @ViewBuilder let icon: Icon

    var body: some View {
        Button(action: {}) {
            icon
        }
        .buttonStyle(.plain)
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
                .foregroundStyle(Palette.textPrimary)
        }
    }
}

private struct SocialButton<Icon: View>: View {
    let label: String
    let handle: String
    @ViewBuilder let icon: Icon

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                icon
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Palette.muted)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.black.opacity(0.03), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.black.opacity(0.03)))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Rewards Content

private struct RewardItem: Identifiable {
    let id: String
    let title: String
    let merchant: String
    let cost: Int
    let icon: String
    let color: Color
}

private let allRewards: [RewardItem] = [
    RewardItem(id: "coffee", title: "Free Large Coffee", merchant: "Bean & Brew", cost: 100, icon: "cup.and.saucer.fill", color: Color(hex: "1B3A2D")),
    RewardItem(id: "haircut", title: "50% Off Haircut", merchant: "Fresh Cuts", cost: 200, icon: "scissors", color: Color(hex: "1A1A2E")),
    RewardItem(id: "yoga", title: "Free Yoga Class", merchant: "Zen Yoga", cost: 150, icon: "figure.mind.and.body", color: Palette.lavender),
    RewardItem(id: "carwash", title: "Free Premium Wash", merchant: "PCA Carwash", cost: 80, icon: "car.fill", color: Palette.sky),
    RewardItem(id: "giftcard", title: "$10 Gift Card", merchant: "Partner Store", cost: 500, icon: "giftcard.fill", color: Palette.goldAccent)
]

private struct RewardsContent: View {
    @EnvironmentObject private var session: SessionViewModel
    @State private var showRedeemAlert = false
    @State private var selectedReward: RewardItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Available Rewards")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Palette.textPrimary)
                Spacer()
                Text("\(session.totalPoints) pts")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(Palette.textSecondary)
            }

            ForEach(allRewards) { reward in
                let redeemed = session.redeemedRewardIDs.contains(reward.id)
                let canAfford = session.totalPoints >= reward.cost

                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(reward.color.opacity(redeemed ? 0.08 : 0.15))
                            .frame(width: 48, height: 48)
                        Image(systemName: redeemed ? "checkmark" : reward.icon)
                            .foregroundStyle(redeemed ? Palette.muted : reward.color)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(reward.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(redeemed ? Palette.muted : Palette.textPrimary)
                        Text(reward.merchant)
                            .font(.caption)
                            .foregroundStyle(Palette.muted)
                    }

                    Spacer()

                    if redeemed {
                        Text("Redeemed")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(Palette.muted)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.black.opacity(0.04), in: Capsule())
                    } else {
                        Button {
                            selectedReward = reward
                            showRedeemAlert = true
                        } label: {
                            Text("\(reward.cost) pts")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    LinearGradient(
                                        colors: canAfford
                                            ? [Color(hex: "1A1A1A"), Color(hex: "333333")]
                                            : [Palette.muted, Palette.muted],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    in: Capsule()
                                )
                        }
                        .disabled(!canAfford)
                    }
                }
                .padding(14)
                .glassCard(cornerRadius: 16, opacity: 0.06, strokeOpacity: 0.08)
                .opacity(redeemed ? 0.7 : 1)
            }
        }
        .alert("Redeem Reward", isPresented: $showRedeemAlert) {
            Button("Cancel", role: .cancel) { selectedReward = nil }
            Button("Redeem") {
                if let reward = selectedReward {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        session.redeemReward(id: reward.id, cost: reward.cost)
                    }
                    selectedReward = nil
                }
            }
        } message: {
            if let reward = selectedReward {
                Text("Redeem \(reward.title) for \(reward.cost) pts?\nYou have \(session.totalPoints) pts.")
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
                    .foregroundStyle(Palette.textPrimary)
                Text("\(session.totalPoints.formatted()) pts")
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
                    .foregroundStyle(Palette.textPrimary)

                HStack(spacing: 10) {
                    ForEach(AppAppearance.allCases) { mode in
                        let selected = session.appearance == mode
                        Button {
                            session.setAppearance(mode)
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: mode.icon)
                                    .font(.title3)
                                    .foregroundStyle(selected ? .white : Palette.muted)
                                Text(mode.label)
                                    .font(.caption.weight(.medium))
                                    .foregroundStyle(selected ? .white : Palette.muted)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                selected ? Color(hex: "1A1A1A") : Color.black.opacity(0.03),
                                in: RoundedRectangle(cornerRadius: 14)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(selected ? Color.clear : Color.black.opacity(0.05))
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
                .foregroundStyle(Palette.textPrimary)
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
                    .foregroundStyle(Palette.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Palette.muted)
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
            Color.white
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
                    .foregroundStyle(Palette.textPrimary)

                QRCodeView(
                    data: "LOOFY-\(session.username.uppercased().replacingOccurrences(of: " ", with: "-"))-8240",
                    size: 220
                )
                .shadow(color: Color.black.opacity(0.08), radius: 24)

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
                        .background(Color(hex: "1A1A1A"), in: RoundedRectangle(cornerRadius: 14))
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
                            .foregroundStyle(selectedTab == tab ? Palette.textPrimary : Palette.muted)
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
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 12, y: -2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(Color.black.opacity(0.04))
            )
            .padding(.horizontal, 12)

            // Raised scan button
            Button {
                showScanner = true
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.04))
                        .frame(width: 80, height: 80)
                        .blur(radius: 8)

                    Circle()
                        .fill(Color(hex: "1A1A1A"))
                        .frame(width: 68, height: 68)
                        .shadow(color: Color.black.opacity(0.15), radius: 14, y: 4)

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

// MARK: - Notifications Sheet

private struct NotificationsSheet: View {
    @EnvironmentObject private var session: SessionViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                if session.notifications.isEmpty {
                    ContentUnavailableView(
                        "No Notifications",
                        systemImage: "bell.slash",
                        description: Text("You're all caught up!")
                    )
                } else {
                    ForEach(session.notifications) { note in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(note.color.opacity(0.15))
                                    .frame(width: 42, height: 42)
                                Image(systemName: note.icon)
                                    .font(.system(size: 16))
                                    .foregroundStyle(note.color)
                            }

                            VStack(alignment: .leading, spacing: 3) {
                                HStack {
                                    Text(note.title)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(Palette.textPrimary)
                                    Spacer()
                                    Text(note.time)
                                        .font(.caption2)
                                        .foregroundStyle(Palette.muted)
                                }
                                Text(note.body)
                                    .font(.caption)
                                    .foregroundStyle(Palette.textSecondary)
                                    .lineLimit(2)
                            }

                            if !note.isRead {
                                Circle()
                                    .fill(Color(hex: "E8455E"))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            session.markRead(note.id)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .foregroundStyle(Palette.textPrimary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if session.unreadCount > 0 {
                        Button("Read All") {
                            withAnimation { session.markAllRead() }
                        }
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Palette.textSecondary)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct CustomerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let session = SessionViewModel()
        session.signIn(as: .customer)
        return NavigationStack {
            CustomerHomeView()
                .environmentObject(session)
        }
    }
}

