
import Foundation

//This is a View Model that stores all recipes, user preferences , and the user daily log. This represents VM.

//Lists of the recipes, log, and user preferences are established here. This also includes the recipes that have been filtered, where the recipes that are available to users are split into two different databases, one for filtered recipes and the other one for all the recipes.
final class MealSuggestionViewModel: ObservableObject {
    @Published var allRecipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var todaysLog: [Recipe] = []
    @Published var userPreferences: UserPreferences = .default
    
    //Calculates the total calories consumed, through the summation of all the meals that had been entered into the log. The functions that are incuded follow OOP principles, where these will be inherited in order maintain the functionality of the application. These will ensure that users are provied with correct information in regard to their calorie intake and progress.

    var totalCaloriesToday: Int {
        todaysLog.reduce(0) { $0 + $1.calories }
    }
    
    //Calculates the remaining calories that are left for the day, through subtracting the calorie goal that is set by the user through the userPreferences and the total calories that had been calcualted for the day.
    var remainingCaloriesToday: Int {
        max(0, userPreferences.calorieGoal - totalCaloriesToday)
    }
    
    // Calcualtes the fraction of how much the goal has been reached by the user.
    var progressToday: Double {
        guard userPreferences.calorieGoal > 0 else { return 0 }
        return min(1.0, Double(totalCaloriesToday) / Double(userPreferences.calorieGoal))
    }
    
    //Dummy dataset has been established here for the recipes that are available.

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
                mealCategory: .quick,
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
    
    
    //This filters the recipes in the databse based on the ingredients that the user inputs in the list. If the user does not enter anything in the list then all the recipes that are availablea are displayed. For each of the recipes that are displayed, this function checks the list first and matches it with the ingredients in the recipe. The recipes that have similar ingredients aas the list will be displayed. This wi;l follow an OOP style deign.

    func filterRecipes(by ingredients: [String]) {
        guard !allRecipes.isEmpty else { filteredRecipes = []; return }
        filteredRecipes = ingredients.isEmpty ? allRecipes :
            allRecipes.filter { recipe in
                ingredients.allSatisfy { ing in
                    recipe.ingredients.contains { $0.name.lowercased().contains(ing.lowercased()) }
                }
            }
    }
    
    //This function is used to filter the recipes through the preferences that are entered by the user.

    func filterByPreferences() {
        filteredRecipes = (filteredRecipes.isEmpty ? allRecipes : filteredRecipes)
            .filter { $0.matches(preferences: userPreferences) }
    }
    
    //Reset the current filters that have been set. This is actioned through a button

    func resetFilters() { filteredRecipes = allRecipes }

    // This function will add the recipe to the list in the log
    func addToToday(_ recipe: Recipe) { todaysLog.append(recipe) }
    //This function will provide users the option to remove a recipe from the log list, if a mistake had been made
    func removeFromToday(at offsets: IndexSet) { todaysLog.remove(atOffsets: offsets) }
    
    // This clears all the recipes from the log list.
    func clearToday() { todaysLog.removeAll() }
}
