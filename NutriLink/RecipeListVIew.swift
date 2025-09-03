import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredRecipes.isEmpty {
                    
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.orange)

                        Text("No meals found")
                            .font(.title2)
                            .bold()

                        Text("Try adding more ingredients or adjusting your preferences.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 60)
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
