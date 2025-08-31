struct UserPreferences: Codable, Equatable {
    var preferredDiet: DietType
    var calorieGoal: Int
    var quickMealsOnly: Bool
}
