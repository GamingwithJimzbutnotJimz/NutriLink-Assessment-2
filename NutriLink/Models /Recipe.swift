
import Foundation

//As protocol extension is used on recipe via FiterableMeal,this will encompass the filtering behaviours. Where when recipes are added they are required to follow the requiements that are set in the protocol. This can be seen in the FilterableMeal file, where the extension is established. As the goal is to establish meals that can be prepared quickly by users, a limit is set on the cooking time for what an acceptable recipe is considered to be. The limit that is set is established to be meals under 20 minutes of preperation. Therefore when data is recorded in these fields, this factor will be checked.
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
