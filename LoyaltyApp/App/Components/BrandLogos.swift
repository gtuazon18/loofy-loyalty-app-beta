import SwiftUI

// MARK: - Starbucks Logo

struct StarbucksLogo: View {
    var size: CGFloat = 32

    var body: some View {
        Image("StarbucksLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

// MARK: - McDonald's Logo

struct McDonaldsLogo: View {
    var size: CGFloat = 32

    var body: some View {
        Image("McDonaldsLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: size * 0.2, style: .continuous))
    }
}

// MARK: - PCA Logo

struct PCALogo: View {
    var size: CGFloat = 32

    var body: some View {
        Image("PCALogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

// MARK: - Merchant Logo View Helper

struct MerchantLogoView: View {
    let logoType: MerchantLogoType
    let fallbackIcon: String
    var size: CGFloat = 20

    var body: some View {
        switch logoType {
        case .sfSymbol(let name):
            Image(systemName: name.isEmpty ? fallbackIcon : name)
                .font(.system(size: size))
                .foregroundStyle(.white.opacity(0.9))
        case .starbucks:
            StarbucksLogo(size: size * 1.8)
        case .mcdonalds:
            McDonaldsLogo(size: size * 1.8)
        case .pca:
            PCALogo(size: size * 1.8)
        }
    }
}

// MARK: - Previews

struct BrandLogos_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StarbucksLogo(size: 64)
            McDonaldsLogo(size: 64)
        }
        .padding()
        .background(Palette.midnight)
        .previewLayout(.sizeThatFits)
    }
}
