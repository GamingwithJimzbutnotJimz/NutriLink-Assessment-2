import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @EnvironmentObject var viewModel: MealSuggestionViewModel

    @State private var showAddedAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                   
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.name)
                            .font(AppFont.titleLarge())
                            .multilineTextAlignment(.leading)
                        
                        //Shows the amount of valories the meal consist of and the time it will take to prepare

                        HStack(spacing: 12) {
                            Label("\(recipe.calories) kcal", systemImage: "flame.fill")
                            Label("\(recipe.cookingTime) min", systemImage: "clock")
                        }
                        .font(AppFont.body())
                        .foregroundColor(AppColor.textSecondary)
                    }
                    .padding()
                    .background(AppColor.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    //Displays ingredients required to prepare the meals
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients")
                            .font(AppFont.title(.semibold))

                        ForEach(recipe.ingredients) { ing in
                            Text("• \(ing.quantity) \(ing.name)")
                                .font(AppFont.body())
                        }
                    }
                    .padding()
                    .background(AppColor.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    //Displays the instruction to ake the meal.
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(AppFont.title(.semibold))

                        ForEach(recipe.instructions.indices, id: \.self) { idx in
                            Text("\(idx + 1). \(recipe.instructions[idx])")
                                .font(AppFont.body())
                        }
                    }
                    .padding()
                    .background(AppColor.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                  //Adds the recipe to the Dashboard list
                    Button {
                        viewModel.addToToday(recipe)
                        showAddedAlert = true
                    } label: {
                        Label("Add to Today’s Log", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(PrimaryButton())
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            
            //Confirmation that the meal had been added to the log
            .navigationTitle("Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Added", isPresented: $showAddedAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("“\(recipe.name)” was added to Today’s log.")
            }
        }
    }
}
