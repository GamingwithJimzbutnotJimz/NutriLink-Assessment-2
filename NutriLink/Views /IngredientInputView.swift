import SwiftUI
//This manages the list for users to input their ingredients.
struct IngredientInputView: View {
    @State private var ingredient: String = ""
    @State private var ingredients: [String] = []

    @State private var navigateToResults = false
    @State private var showPreferences = false

    @State private var showNoResultsAlert = false
    @State private var showInputAlert = false
    @State private var inputAlertMessage = ""

    @EnvironmentObject var viewModel: MealSuggestionViewModel

    private let chipColumns = [GridItem(.adaptive(minimum: 110), spacing: 8)]


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    //Title of the page
                    Text("Enter Ingredients")
                        .font(AppFont.titleLarge())
                    //Text field for inputting ingredients with a button that actions this, and enters the ingredient into the ingredient list. The button is also disabed when there are whitespaces available in order to reduce user input error.
                   
                    HStack(spacing: 10) {
                        TextField("e.g. chicken", text: $ingredient)
                            .textFieldStyle(.roundedBorder)
                            .font(AppFont.body())

                        Button(action: addCurrentIngredient) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(AppColor.brand)
                        }
                        .disabled(trimmedInput().isEmpty)
                    }

                    //Shows the list of ingredietns that are entered into the lost. Only appears when the actios the command with the buttomn that adds the ingredients. Users can also remove items from the list through a deleted option that appears underneath the listed item.
                    if !ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Added Ingredients")
                                .font(AppFont.title(.semibold))
                                .foregroundColor(AppColor.textSecondary)

                            LazyVGrid(columns: chipColumns, alignment: .leading, spacing: 8) {
                                ForEach(ingredients, id: \.self) { item in
                                    HStack(spacing: 6) {
                                        Text(item.capitalized)
                                            .font(AppFont.body())
                                            .lineLimit(1)
                                        Button {
                                            ingredients.removeAll { $0 == item }
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.caption)
                                                .foregroundColor(AppColor.textSecondary)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(AppColor.cardBackground)
                                    .clipShape(Capsule())
                                }
                            }

                            Button(role: .destructive) {
                                ingredients.removeAll()
                            } label: {
                                Label("Clear Ingredients", systemImage: "trash")
                                    .font(AppFont.body())
                            }
                            .padding(.top, 2)
                        }
                        .cardStyle()
                    }

                    // This is the button that is actioned to go the users preferences view.
                    
                    Button {
                        showPreferences = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "slider.horizontal.3")
                            Text("Set Preferences")
                                .font(AppFont.body())
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(AppColor.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    Spacer(minLength: 8)
                    // This button utilises the set preferences and ingredients in order to go to the RecipeListView. If there are no mathes foudn an error window is displayed to the users.
                    Button {
                        viewModel.filterRecipes(by: ingredients)
                        viewModel.filterByPreferences()
                        if viewModel.filteredRecipes.isEmpty {
                            showNoResultsAlert = true
                        } else {
                            navigateToResults = true
                        }
                    } label: {
                        Label("Find Meals", systemImage: "sparkles")
                    }
                    .buttonStyle(PrimaryButton())
                    .padding(.top, 4)

                    
                    NavigationLink(
                        destination: RecipeListView().environmentObject(viewModel),
                        isActive: $navigateToResults
                    ) { EmptyView() }
                    .hidden()

                    NavigationLink(
                        destination: PreferencesView().environmentObject(viewModel),
                        isActive: $showPreferences
                    ) { EmptyView() }
                    .hidden()
                }
                .padding()
            }
            .navigationTitle("Meals")
            .background(Color(.systemBackground).ignoresSafeArea())

            //Error Handling
            .alert("Input Problem", isPresented: $showInputAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(inputAlertMessage)
            }
            .alert("No meals found", isPresented: $showNoResultsAlert) {
                Button("OK", role: .cancel) { }
                Button("Reset Filters") {
                    ingredients.removeAll()
                    viewModel.resetFilters()
                }
            } message: {
                Text("Try removing some ingredients, loosening preferences, or tap \"Reset Filters\" to see all recipes again.")
            }
        }
    }

   

    private func trimmedInput() -> String {
        ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func addCurrentIngredient() {
        let trimmed = trimmedInput().lowercased()
        guard !trimmed.isEmpty else {
            inputAlertMessage = "Ingredient can't be empty."
            showInputAlert = true
            return
        }
        guard !ingredients.contains(trimmed) else {
            inputAlertMessage = "\"\(trimmed.capitalized)\" is already added."
            showInputAlert = true
            return
        }
        ingredients.append(trimmed)
        ingredient = ""
    }
}
