
import Foundation

struct Recipe: Identifiable, Codable {
    let id = UUID()
    var name: String
    var ingredients: [Ingredient]
    var cookingTime: Int
    var calories: Int
    var dietTags: [DietType]
    var mealCategory: MealCategory
    var instructions: [String]
}
