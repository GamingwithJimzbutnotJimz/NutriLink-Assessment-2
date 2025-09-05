import Foundation
import Combine

final class TaskStore: ObservableObject {
    @Published private(set) var tasks: [Task] = []


    init() {
        tasks = [
            Task(title: "Plan meals for the week", notes: "Use quick meals", dueDate: Date().addingTimeInterval(60*60*24), type: .personal),
            Task(title: "Prep Veggie Stir Fry", notes: "Try low sodium soy sauce", dueDate: nil, type: .mealPrep, relatedRecipeID: nil),
            Task(title: "Buy groceries", notes: nil, dueDate: Date().addingTimeInterval(60*60*48), type: .shopping, relatedRecipeID: nil, shoppingItems: ["Oats","Milk","Broccoli"])
        ]
    }


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

    func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleDone(for taskID: UUID) {
        guard let idx = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        tasks[idx].toggleDone()
    }

    // MARK: - Derived views
    var overdueTasks: [Task] {
        tasks.filter { $0.isOverdue() }
    }

    func tasks(of type: TaskType?) -> [Task] {
        guard let type else { return tasks }
        return tasks.filter { $0.type == type }
    }
}
