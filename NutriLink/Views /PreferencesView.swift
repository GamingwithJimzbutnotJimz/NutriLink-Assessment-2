import SwiftUI

//This view manages user preferences, where users can set their preferences.
struct PreferencesView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Dietary Preference").font(AppFont.caption())) {
                    Picker("Preferred Diet", selection: $viewModel.userPreferences.preferredDiet) {
                        ForEach(DietType.allCases, id: \.self) { diet in
                            Text(displayName(for: diet))
                                .font(AppFont.body())
                                .tag(diet)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                Section(header: Text("Meal Filters").font(AppFont.caption())) {
                    Toggle("Quick Meals Only", isOn: $viewModel.userPreferences.quickMealsOnly)
                        .font(AppFont.body())
                    //Allows users to set their calorie goal throug a step counter.
                    Stepper(value: $viewModel.userPreferences.calorieGoal, in: 800...4000, step: 100) {
                        Text("Calorie Goal: \(viewModel.userPreferences.calorieGoal) kcal")
                            .font(AppFont.body())
                            .foregroundColor(AppColor.textPrimary)
                    }
                }
            }
            .navigationTitle("Preferences")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .foregroundColor(AppColor.brand)
                        .font(AppFont.body())
                }
            }
            .tint(AppColor.brand)
        }
        .onChange(of: viewModel.userPreferences) { _ in
            viewModel.filterByPreferences()
        }
    }
    
    //This provides users the option to choose a type of meal that they would like to be recomended

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
