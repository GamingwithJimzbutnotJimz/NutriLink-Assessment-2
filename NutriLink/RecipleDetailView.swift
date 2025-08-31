import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text("Ingredients:")
                    .font(.headline)

                ForEach(recipe.ingredients) { ingredient in
                    Text("• \(ingredient.quantity) \(ingredient.name)")
                }

                Text("Instructions:")
                    .font(.headline)
                    .padding(.top)

                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.instructions[index])")
                }
            }
            .padding()
        }
    }
}
