import SwiftUI

struct IngredientInputView: View {
    @State private var ingredient: String = ""
    @State private var ingredients: [String] = []
    @State private var navigateToResults = false
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Enter Ingredients")
                    .font(.largeTitle)
                    .bold()

                HStack {
                    TextField("e.g. chicken", text: $ingredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        if !ingredient.isEmpty {
                            ingredients.append(ingredient.lowercased())
                            ingredient = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(ingredient.isEmpty)
                }

                if !ingredients.isEmpty {
                    Text("Added Ingredients:")
                        .font(.headline)

                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item.capitalized)")
                    }
                }

                Spacer()

                Button("Find Meals") {
                    viewModel.filterRecipes(by: ingredients)
                    navigateToResults = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.top)

                NavigationLink(destination: RecipeListView()
                                .environmentObject(viewModel),
                               isActive: $navigateToResults) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}
