import SwiftUI

@main
struct NutriLinkApp: App {
    @StateObject private var viewModel = MealSuggestionViewModel()
    @StateObject private var taskVM = TaskManagerViewModel()

    var body: some Scene {
        WindowGroup {
            TabView {
    
                NavigationStack {
                    IngredientInputView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Meals", systemImage: "leaf")
                }

         
                NavigationStack {
                    TaskListView(taskVM: taskVM)
                }
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.square")
                }
            }
        }
    }
}
