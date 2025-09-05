import SwiftUI

struct DailyNutritionView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                HStack(spacing: 16) {
                    StatCard(title: "Goal",
                             valueText: String(viewModel.userPreferences.calorieGoal),
                             unit: "kcal")
                    StatCard(title: "Consumed",
                             valueText: String(viewModel.totalCaloriesToday),
                             unit: "kcal")
                    StatCard(title: "Remaining",
                             valueText: String(viewModel.remainingCaloriesToday),
                             unit: "kcal")
                }
                .padding(.horizontal)

                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Today's Progress").font(.headline)
                    ProgressView(value: viewModel.progressToday)
                        .tint(viewModel.progressToday >= 1.0 ? .red : .blue)
                        .animation(.easeInOut, value: viewModel.progressToday)
                }
                .padding(.horizontal)

                
                List {
                    if viewModel.todaysLog.isEmpty {
                        Section {
                            Text("No meals logged yet. Add from a recipe’s detail screen.")
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Section(header: Text("Today’s Log")) {
                            ForEach(viewModel.todaysLog) { recipe in
                                HStack {
                                    Text(recipe.name)
                                    Spacer()
                                    Text("\(recipe.calories) kcal")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onDelete(perform: viewModel.removeFromToday)
                        }
                        Section {
                            Button(role: .destructive) {
                                viewModel.clearToday()
                            } label: {
                                Label("Clear Today", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}
