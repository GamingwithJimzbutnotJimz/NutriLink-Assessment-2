import SwiftUI

struct TaskListView: View {
    @StateObject var store = TaskStore()
    @State private var showNew = false
    @State private var filter: TaskType? = nil

    var body: some View {
        NavigationStack {
            List {
                if !store.overdueTasks.isEmpty {
                    Section("Overdue") {
                        ForEach(store.overdueTasks) { task in
                            TaskRow(task: task) { store.toggleDone(for: task.id) }
                        }
                        .onDelete(perform: store.delete)
                    }
                }

                Section(filterTitle) {
                    ForEach(store.tasks(of: filter)) { task in
                        TaskRow(task: task) { store.toggleDone(for: task.id) }
                    }
                    .onDelete(perform: store.delete)
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button("All") { filter = nil }
                        ForEach(TaskType.allCases, id: \.self) { t in
                            Button(t.rawValue.capitalized) { filter = t }
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNew = true
                    } label: {
                        Label("New Task", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNew) {
                TaskEditorView(store: store,
                               task: Task(title: "", notes: nil, dueDate: Date(), type: .personal))
            }
        }
    }

    private var filterTitle: String {
        filter == nil ? "All Tasks" : "\(filter!.rawValue.capitalized) Tasks"
    }
}

private struct TaskRow: View {
    let task: Task
    let toggle: () -> Void

    var body: some View {
        HStack {
            Button(action: toggle) {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isDone ? .green : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .strikethrough(task.isDone)
                    .font(.body)
                HStack(spacing: 8) {
                    Text(task.type.rawValue.capitalized).foregroundStyle(.secondary)
                    if let due = task.dueDate {
                        Text(due, style: .date).foregroundStyle(.secondary)
                    }
                }
                .font(.caption)
            }
            Spacer()
            if task.isOverdue() {
                Text("Overdue").font(.caption2).foregroundColor(.red)
            }
        }
    }
}
