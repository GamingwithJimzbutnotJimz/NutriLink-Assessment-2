import SwiftUI

@main
struct NutriLinkApp: App {
    @StateObject private var viewModel = MealSuggestionViewModel()

    var body: some Scene {
        WindowGroup {
            IngredientInputView()
                .environmentObject(viewModel)
        }
    }
}

