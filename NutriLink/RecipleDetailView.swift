import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(recipe.calories) kcal • \(recipe.cookingTime) min")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider().padding(.vertical, 4)

            Text("Ingredients").font(.headline)
            ForEach(recipe.ingredients) { ing in
                Text("• \(ing.quantity) \(ing.name)")
            }

            Divider().padding(.vertical, 4)

            Text("Instructions").font(.headline)
            ForEach(recipe.instructions.indices, id: \.self) { i in
                Text("\(i + 1). \(recipe.instructions[i])")
            }

            Button {
                viewModel.addToToday(recipe)      
            } label: {
                Label("Add to Today's Log", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.top, 8)

            Spacer(minLength: 0)
        }
        .padding()
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}
