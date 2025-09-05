
import Foundation

protocol FilterableMeal {
    func matches(preferences: UserPreferences) -> Bool
}

extension Recipe: FilterableMeal {
    func matches(preferences: UserPreferences) -> Bool {
        let dietOK  = preferences.preferredDiet == .none
                   || dietTags.contains(preferences.preferredDiet)
        let quickOK = !preferences.quickMealsOnly || cookingTime <= 20
        let catOK: Bool = {
            if let wanted = preferences.selectedMealCategory {
                return mealCategory == wanted
            }
            return true
        }()
        return dietOK && quickOK && catOK
    }
}
