import Foundation

//OOP Implemented here to ensure properties and functions maintain the same function accross all the views if required
protocol TaskProtocol: Identifiable, Codable, Equatable {
    var id: UUID { get }
    var title: String { get set }
    var notes: String? { get set }
    var dueDate: Date? { get set }
    var isDone: Bool { get set }
    var type: TaskType { get set }
    var createdAt: Date { get }
    var updatedAt: Date { get set }

    mutating func toggleDone()
    func isOverdue(reference: Date) -> Bool
    func validate() throws
}

enum TaskType: String, Codable, CaseIterable, Equatable {
    case personal
    case mealPrep
    case shopping
}



enum TaskValidationError: LocalizedError {
    case emptyTitle
    case invalidDueDate

    var errorDescription: String? {
        switch self {
        case .emptyTitle:      return "Title cannot be empty."
        case .invalidDueDate:  return "Due date cannot be in the past."
        }
    }
}


struct Task: TaskProtocol {
    var id: UUID = UUID()
    var title: String
    var notes: String?
    var dueDate: Date?
    var isDone: Bool = false
    var type: TaskType
    let createdAt: Date = Date()
    var updatedAt: Date = Date()

    
    var relatedRecipeID: UUID?
    var shoppingItems: [String]?

        //The behaviour of this function updates as the data is entered
    mutating func toggleDone() {
        isDone.toggle()
        updatedAt = Date()
    }

    func isOverdue(reference: Date = Date()) -> Bool {
        guard let due = dueDate, !isDone else { return false }
        return due < reference
    }

    
    func validate() throws {
        //This ensures validatin is kept simple and local to the model
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw TaskValidationError.emptyTitle
        }
        if let due = dueDate, due < Date().addingTimeInterval(-60) {
            throw TaskValidationError.invalidDueDate
        }
    }
}
