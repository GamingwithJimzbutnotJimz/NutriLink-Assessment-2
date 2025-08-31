import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredRecipes.isEmpty {
                    Text("No meals found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text("\(recipe.calories) kcal • \(recipe.cookingTime) min")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Suggested Meals")
            .onAppear {
                viewModel.loadSampleRecipes()
            }
        }
    }
}
