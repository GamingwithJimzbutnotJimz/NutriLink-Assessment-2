
import Foundation

struct UserPreferences: Codable, Equatable {
    var preferredDiet: DietType
    var calorieGoal: Int
    var quickMealsOnly: Bool
    var selectedMealCategory: MealCategory?   

    static let `default` = UserPreferences(
        preferredDiet: .none,
        calorieGoal: 2000,
        quickMealsOnly: false,
        selectedMealCategory: nil
    )
}
