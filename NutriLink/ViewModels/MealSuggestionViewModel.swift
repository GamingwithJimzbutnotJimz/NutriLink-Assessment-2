import Foundation

class MealSuggestionViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    
    var userPreferences: UserPreferences = UserPreferences(preferredDiet: .none, calorieGoal: 2000, quickMealsOnly: false)

    init() {
        loadSampleRecipes()
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
                instructions: ["Boil oats with milk", "Add toppings", "Enjoy"]
            )
        ]

        filteredRecipes = allRecipes
    }

    func filterRecipes(by ingredients: [String]) {
        if ingredients.isEmpty {
            filteredRecipes = allRecipes
            return
        }

        filteredRecipes = allRecipes.filter { recipe in
            ingredients.allSatisfy { ing in
                recipe.ingredients.contains { ingredient in
                    ingredient.name.lowercased().contains(ing)
                }
            }
        }
    }

    func filterByPreferences() {
        filteredRecipes = filteredRecipes.filter { recipe in
            (userPreferences.preferredDiet == .none || recipe.dietTags.contains(userPreferences.preferredDiet)) &&
            (!userPreferences.quickMealsOnly || recipe.cookingTime <= 20)
        }
    }
}
