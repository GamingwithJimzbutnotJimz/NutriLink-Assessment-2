
import Foundation

final class MealSuggestionViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var todaysLog: [Recipe] = []
    @Published var userPreferences: UserPreferences = .default   // ← Published

    var totalCaloriesToday: Int {
        todaysLog.reduce(0) { $0 + $1.calories }
    }
    var remainingCaloriesToday: Int {
        max(0, userPreferences.calorieGoal - totalCaloriesToday)
    }
    var progressToday: Double {
        guard userPreferences.calorieGoal > 0 else { return 0 }
        return min(1.0, Double(totalCaloriesToday) / Double(userPreferences.calorieGoal))
    }

    func loadSampleRecipes() {
        allRecipes = [
            Recipe(
                name: "Veggie Stir Fry",
                ingredients: [
                    Ingredient(name: "Broccoli", quantity: "1 cup"),
                    Ingredient(name: "Soy Sauce", quantity: "2 tbsp")
                ],
                cookingTime: 15,
                calories: 400,
                dietTags: [.vegetarian],
                mealCategory: .quick,                 // ← compiles now
                instructions: ["Chop veggies", "Stir fry in pan", "Serve hot"]
            ),
            Recipe(
                name: "Oatmeal Bowl",
                ingredients: [
                    Ingredient(name: "Oats", quantity: "1/2 cup"),
                    Ingredient(name: "Milk", quantity: "1 cup")
                ],
                cookingTime: 10,
                calories: 350,
                dietTags: [.vegetarian],
                mealCategory: .quick,
                instructions: ["Boil oats with milk", "Add toppings", "Enjoy"]
            ),
            Recipe(
                name: "Grilled Chicken",
                ingredients: [
                    Ingredient(name: "Chicken Breast", quantity: "200g"),
                    Ingredient(name: "Olive Oil", quantity: "1 tbsp")
                ],
                cookingTime: 30,
                calories: 600,
                dietTags: [.highProtein],
                mealCategory: .highProtein,
                instructions: ["Season chicken", "Grill until cooked", "Serve"]
            )
        ]
        filteredRecipes = allRecipes
    }

    func filterRecipes(by ingredients: [String]) {
        guard !allRecipes.isEmpty else { filteredRecipes = []; return }
        filteredRecipes = ingredients.isEmpty ? allRecipes :
            allRecipes.filter { recipe in
                ingredients.allSatisfy { ing in
                    recipe.ingredients.contains { $0.name.lowercased().contains(ing.lowercased()) }
                }
            }
    }

    func filterByPreferences() {
        filteredRecipes = (filteredRecipes.isEmpty ? allRecipes : filteredRecipes)
            .filter { $0.matches(preferences: userPreferences) }   // ← now found
    }

    func resetFilters() { filteredRecipes = allRecipes }

    func addToToday(_ recipe: Recipe) { todaysLog.append(recipe) }
    func removeFromToday(at offsets: IndexSet) { todaysLog.remove(atOffsets: offsets) }
    func clearToday() { todaysLog.removeAll() }
}
