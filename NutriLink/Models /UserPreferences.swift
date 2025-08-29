import Foundation

struct UserPreferences: Codable {
    var preferredDiet: DietType
    var calorieGoal: Int
    var quickMealsOnly: Bool
}
