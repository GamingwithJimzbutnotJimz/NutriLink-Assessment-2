import Foundation

struct Recipe: Identifiable, Codable {
    let id = UUID()
    var name: String
    var ingredients: [Ingredient]
    var cookingTime: Int // in minutes
    var calories: Int
    var dietTags: [DietType]
    var instructions: [String]
}


