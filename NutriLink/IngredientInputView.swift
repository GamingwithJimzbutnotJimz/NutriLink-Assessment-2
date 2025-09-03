import SwiftUI

struct IngredientInputView: View {
    @State private var ingredient: String = ""
    @State private var ingredients: [String] = []
    @State private var navigateToResults = false
    @State private var showPreferences = false

    @State private var showAlert = false
    @State private var alertMessage = ""

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

                    Button {
                        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

                        guard !trimmed.isEmpty else {
                            alertMessage = "Ingredient cannot be empty."
                            showAlert = true
                            return
                        }

                        guard !ingredients.contains(trimmed) else {
                            alertMessage = "You already added “\(trimmed)”."
                            showAlert = true
                            return
                        }

                        ingredients.append(trimmed)
                        ingredient = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if !ingredients.isEmpty {
                    Text("Added Ingredients:")
                        .font(.headline)

                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item.capitalized)")
                    }
                }

                Button("Set Preferences") {
                    showPreferences = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Spacer()

                Button("Find Meals") {
                    viewModel.filterRecipes(by: ingredients)
                    viewModel.filterByPreferences()
                    navigateToResults = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                NavigationLink(
                    destination: RecipeListView().environmentObject(viewModel),
                    isActive: $navigateToResults
                ) { EmptyView() }

                NavigationLink(
                    destination: PreferencesView().environmentObject(viewModel),
                    isActive: $showPreferences
                ) { EmptyView() }
            }
            .padding()
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Input Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
