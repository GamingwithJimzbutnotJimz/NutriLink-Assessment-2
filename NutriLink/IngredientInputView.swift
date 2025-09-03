import SwiftUI

struct IngredientInputView: View {
    @State private var ingredient: String = ""
    @State private var ingredients: [String] = []

    @State private var navigateToResults = false
    @State private var showPreferences = false

   
    @State private var showNoResultsAlert = false

    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Enter Ingredients")
                    .font(.largeTitle).bold()

                HStack {
                    TextField("e.g. chicken", text: $ingredient)
                        .textFieldStyle(.roundedBorder)

                    Button {
                        guard !ingredient.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        ingredients.append(ingredient.lowercased().trimmingCharacters(in: .whitespaces))
                        ingredient = ""
                    } label: {
                        Image(systemName: "plus.circle.fill").font(.title2)
                    }
                    .disabled(ingredient.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                if !ingredients.isEmpty {
                    Text("Added Ingredients:").font(.headline)
                    ForEach(ingredients, id: \.self) { item in
                        Text("• \(item.capitalized)")
                    }

                    Button(role: .destructive) {
                        ingredients.removeAll()
                    } label: {
                        Label("Clear Ingredients", systemImage: "trash")
                    }
                    .padding(.top, 4)
                }

                Button("Set Preferences") {
                    showPreferences = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(10)

                Spacer()

                Button("Find Meals") {
                    // Apply filters
                    viewModel.filterRecipes(by: ingredients)
                    viewModel.filterByPreferences()

                    
                    if viewModel.filteredRecipes.isEmpty {
                        showNoResultsAlert = true
                    } else {
                        navigateToResults = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)

                // Navigation
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
            
            .alert("No meals found", isPresented: $showNoResultsAlert) {
                Button("OK", role: .cancel) { }
                Button("Reset Filters") {
                    // simple recovery path
                    ingredients.removeAll()
                    viewModel.filteredRecipes = viewModel.allRecipes
                }
            } message: {
                Text("""
                     Try removing some ingredients, lowering your calorie target, \
                     or turning off ‘Quick Meals Only’. You can also tap ‘Reset Filters’ \
                     to see all recipes again.
                     """)
            }
        }
    }
}
