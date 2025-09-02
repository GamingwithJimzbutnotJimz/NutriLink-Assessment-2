import Foundation

class TaskManagerViewModel: ObservableObject {
    @Published var tasks: [BaseTask] = []

    func addTask(_ task: BaseTask) {
        tasks.append(task)
    }

    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
