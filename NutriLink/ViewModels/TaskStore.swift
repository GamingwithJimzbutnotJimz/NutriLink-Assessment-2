import Foundation
import Combine
//This works as a database to store all the tasks that users have entered to do in order to acheive their healthy eating habits.
final class TaskStore: ObservableObject {
    @Published private(set) var tasks: [Task] = []

    //This acts as a dummy database that losts the task name for iusers, any notes for instructions on how to complete the task, a time interval for the user to complete their task and the category that the task will reside in.
    init() {
        tasks = [
            Task(title: "Plan meals for the week", notes: "Use quick meals", dueDate: Date().addingTimeInterval(60*60*24), type: .personal),
            Task(title: "Prep Veggie Stir Fry", notes: "Try low sodium soy sauce", dueDate: nil, type: .mealPrep, relatedRecipeID: nil),
            Task(title: "Buy groceries", notes: nil, dueDate: Date().addingTimeInterval(60*60*48), type: .shopping, relatedRecipeID: nil, shoppingItems: ["Oats","Milk","Broccoli"])
        ]
    }

    //This checks if the task that is entered is in the correct format.
    @discardableResult
    func add(_ task: Task) -> Result<Void, Error> {
        do {
            try task.validate()
            tasks.append(task)
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    // Update an existing task by replacing the entry with the same `id`.
    func update(_ task: Task) -> Result<Void, Error> {
        guard let idx = tasks.firstIndex(where: { $0.id == task.id }) else { return .success(()) }
        do {
            try task.validate()
            tasks[idx] = task
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    // Provides users the option to remove any tasks that are in the list

    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleDone(for taskID: UUID) {
        guard let idx = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        tasks[idx].toggleDone()
    }

    // MARK: - Derived views
    
    //Return tasks that ar eoverdue 
    var overdueTasks: [Task] {
        tasks.filter { $0.isOverdue() }
    }

    func tasks(of type: TaskType?) -> [Task] {
        guard let type else { return tasks }
        return tasks.filter { $0.type == type }
    }
}
