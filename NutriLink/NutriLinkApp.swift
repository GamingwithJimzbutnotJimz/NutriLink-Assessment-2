import SwiftUI

@main
struct NutriLinkApp: App {
    @StateObject private var mealVM = MealSuggestionViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                IngredientInputView()
                    .environmentObject(mealVM)
                    .tabItem { Label("Meals", systemImage: "fork.knife") }

                TaskListView()
                    .tabItem { Label("Tasks", systemImage: "checklist") }
            }
        }
    }
}
