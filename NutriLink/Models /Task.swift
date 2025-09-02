import Foundation


protocol Task {
    var title: String { get set }
    var dueDate: Date? { get set }
    func execute()
}



class BaseTask: Task, Identifiable {
    var id = UUID()
    var title: String
    var dueDate: Date?

    init(title: String, dueDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
    }

    func execute() {
        print("Executing generic task: \(title)")
    }
}



class GroceryTask: BaseTask {
    var ingredients: [Ingredient]

    init(title: String, ingredients: [Ingredient], dueDate: Date? = nil) {
        self.ingredients = ingredients
        super.init(title: title, dueDate: dueDate)
    }

    override func execute() {
        print("Buy: \(ingredients.map { $0.name }.joined(separator: ", "))")
    }
}



class MealPrepTask: BaseTask {
    var recipeName: String

    init(title: String, recipeName: String, dueDate: Date? = nil) {
        self.recipeName = recipeName
        super.init(title: title, dueDate: dueDate)
    }

    override func execute() {
        print("Prep recipe: \(recipeName)")
    }
}
