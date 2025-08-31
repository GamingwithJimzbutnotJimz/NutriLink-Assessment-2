import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dietary Preference")) {
                    Picker("Preferred Diet", selection: $viewModel.userPreferences.preferredDiet) {
                        ForEach(DietType.allCases, id: \.self) { diet in
                            Text(displayName(for: diet)).tag(diet)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section(header: Text("Meal Filters")) {
                    Toggle("Quick Meals Only", isOn: $viewModel.userPreferences.quickMealsOnly)
                    Stepper(value: $viewModel.userPreferences.calorieGoal, in: 800...4000, step: 100) {
                        Text("Calorie Goal: \(viewModel.userPreferences.calorieGoal) kcal")
                    }
                }
            }
            .navigationTitle("Preferences")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        
        .onChange(of: viewModel.userPreferences) { _ in
            viewModel.filterByPreferences()
        }
    }

    private func displayName(for diet: DietType) -> String {
        switch diet {
        case .vegetarian: return "Vegetarian"
        case .vegan: return "Vegan"
        case .glutenFree: return "Gluten-Free"
        case .lowCarb: return "Low-Carb"
        case .highProtein: return "High-Protein"
        case .none: return "None"
        }
    }
}
