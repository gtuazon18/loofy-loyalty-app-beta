import Foundation

enum UserRole: String, CaseIterable, Identifiable {
    case customer
    case merchant
    case admin

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .customer: return "Customer"
        case .merchant: return "Merchant"
        case .admin: return "Admin"
        }
    }

    var iconName: String {
        switch self {
        case .customer: return "person.crop.circle"
        case .merchant: return "barcode.viewfinder"
        case .admin: return "shield.lefthalf.filled"
        }
    }
}
