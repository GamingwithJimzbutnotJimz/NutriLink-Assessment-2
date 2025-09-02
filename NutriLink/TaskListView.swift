import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskVM = TaskManagerViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(taskVM.tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        if let date = task.dueDate {
                            Text("Due: \(date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Text("Type: \(type(of: task))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: taskVM.removeTask)
            }
            .navigationTitle("My Tasks")
            .toolbar {
                Button("Add Sample") {
                    let sample = GroceryTask(title: "Buy veggies", ingredients: [Ingredient(name: "Carrots", quantity: "2")])
                    taskVM.addTask(sample)
                }
            }
        }
    }
}
