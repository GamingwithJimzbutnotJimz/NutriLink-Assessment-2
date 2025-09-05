import Foundation

enum MealCategory: String, Codable, CaseIterable, Identifiable {
    case quick
    case highProtein
    case breakfast
    case lunch
    case dinner
    case snack

    var id: String { rawValue }

    var title: String {
        switch self {
        case .quick: return "Quick"
        case .highProtein: return "High Protein"
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        case .snack: return "Snack"
        }
    }

    var systemImage: String {
        switch self {
        case .quick: return "bolt.fill"
        case .highProtein: return "dumbbell.fill"
        case .breakfast: return "sunrise.fill"
        case .lunch: return "fork.knife"
        case .dinner: return "moon.stars.fill"
        case .snack: return "takeoutbag.and.cup.and.straw.fill"
        }
    }
}

