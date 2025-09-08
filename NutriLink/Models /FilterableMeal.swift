
import Foundation
//This utilises protocol oriented logic, where it is used in the recipe handling functions. This allows the same logic to be utilised across all the functions that are utilising recipe. In this in order to ensure that this is hapenning, FilterableMeal is used aas an extension for Recipe. Therefore we are able to use user prefereces, in order to implement our logic into the Recipes views.
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
