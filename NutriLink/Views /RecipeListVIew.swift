import SwiftUI

//This view manages the recipe list that derives information from the MealSuggestionViewModel
struct RecipeListView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.filteredRecipes.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "fork.knife.circle.fill")
                            .font(.system(size: 56))
                            .foregroundColor(.secondary)
                        //Displays text if the there are no meals that are found through the preferences.
                        Text("No meals found")
                            .font(.title2).bold()

                        Text("Try adding more ingredients or loosening your preferences.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 60)
                } else {
                    List(viewModel.filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(.secondarySystemBackground))
                                        .frame(width: 52, height: 52)
                                    Image(systemName: "leaf")
                                        .foregroundColor(.green)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(recipe.name)
                                        .font(.headline)
                                    Text("\(recipe.calories) kcal • \(recipe.cookingTime) min")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Suggested Meals")
            .onAppear { viewModel.loadSampleRecipes() }
        }
    }
}
