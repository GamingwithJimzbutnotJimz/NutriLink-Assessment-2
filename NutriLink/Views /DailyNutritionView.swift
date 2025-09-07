import SwiftUI

//This is the dashboard view, showing the users daily nutrition summary.
struct DailyNutritionView: View {
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

               // Will show the users Goal, Consumed calories, Remaining Calories. These derive values from the functions that are set in the MealSuggestionViewModel
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

          
                VStack(alignment: .leading, spacing: 10) {
                    Text("Today's Progress")
                        .font(AppFont.title(.semibold))
                    // This is the progress bar that functions through the progressToday function established in the MealSuggestionViewModel
                    ProgressView(value: viewModel.progressToday)
                        .tint(viewModel.progressToday >= 1.0 ? .red : AppColor.brand)
                        .frame(height: 12)
                        .clipShape(Capsule())
                        .animation(.easeInOut, value: viewModel.progressToday)
                }
                .cardStyle()
                .padding(.horizontal)

                //If there exists no meals in the list then a message will display there as default indicating to the user that no meals are logged as of yet.
                List {
                    if viewModel.todaysLog.isEmpty {
                        Section {
                            Text("No meals logged yet. Add from a recipe’s detail screen.")
                                .foregroundColor(AppColor.textSecondary)
                                .font(AppFont.body())
                            
                        }
                        
                        //else meals that are inputted will eb displayed, with the number of calories each meal consists of and the name. This provides the user to also delete the specific meals through swiping.
                    } else {
                        Section(header: Text("Today’s Log").font(AppFont.title(.semibold))) {
                            ForEach(viewModel.todaysLog) { recipe in
                                HStack {
                                    Text(recipe.name)
                                        .font(AppFont.body())
                                    Spacer()
                                    Text("\(recipe.calories) kcal")
                                        .font(AppFont.caption())
                                        .foregroundColor(AppColor.textSecondary)
                                }
                            }
                            .onDelete(perform: viewModel.removeFromToday)
                        }
                        //All items can be removed from the list through a button that is displayed
                        Section {
                            Button(role: .destructive) {
                                viewModel.clearToday()
                            } label: {
                                Label("Clear Today", systemImage: "trash")
                                    .font(AppFont.body())
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Dashboard")
        }
    }
}
