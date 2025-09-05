import SwiftUI

@main
struct NutriLinkApp: App {
    @StateObject private var mealVM = MealSuggestionViewModel()
    @StateObject private var taskStore = TaskStore()

    var body: some Scene {
        WindowGroup {
            TabView {
               
                IngredientInputView()
                    .environmentObject(mealVM)
                    .tabItem { Label("Meals", systemImage: "fork.knife") }

                
                DailyNutritionView()
                    .environmentObject(mealVM)
                    .tabItem { Label("Dashboard", systemImage: "chart.bar.fill") }

                
                TaskListView()
                    .environmentObject(taskStore)
                    .tabItem { Label("Tasks", systemImage: "checklist") }
            }
            
            .task { mealVM.loadSampleRecipes() }
        }
    }
}
