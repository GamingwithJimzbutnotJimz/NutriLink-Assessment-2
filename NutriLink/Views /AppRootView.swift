import SwiftUI

struct AppRootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                IngredientInputView()
            }
            .tabItem { Label("Meals", systemImage: "fork.knife") }

            DailyNutritionView()
                .tabItem { Label("Dashboard", systemImage: "chart.bar") }
        }
    }
}
