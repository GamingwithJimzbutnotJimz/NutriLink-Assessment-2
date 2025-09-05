import SwiftUI

struct TaskEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var store: TaskStore
    @State var task: Task

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $task.title)
                    TextField("Notes (optional)", text: Binding(
                        get: { task.notes ?? "" },
                        set: { task.notes = $0.isEmpty ? nil : $0 }
                    ))
                    Picker("Type", selection: $task.type) {
                        ForEach(TaskType.allCases, id: \.self) { t in
                            Text(t.rawValue.capitalized).tag(t)
                        }
                    }
                    Toggle("Done", isOn: $task.isDone)
                    DatePicker("Due Date", selection: Binding(
                        get: { task.dueDate ?? Date() },
                        set: { task.dueDate = $0 }
                    ), displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "en_AU"))
                    .onAppear {
                        if task.dueDate == nil { task.dueDate = Date() }
                    }
                }

                if task.type == .shopping {
                    Section("Shopping Items") {
                        ForEach(task.shoppingItems ?? [], id: \.self) { item in
                            Text("• \(item)")
                        }
                    }
                }
            }
            .navigationTitle(task.id == UUID() ? "New Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        switch store.addOrUpdate(task) {
                        case .success:
                            dismiss()
                        case .failure(let err):
                            alertMessage = err.localizedDescription
                            showAlert = true
                        }
                    }
                }
            }
            .alert("Invalid Task", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

private extension TaskStore {
    func addOrUpdate(_ task: Task) -> Result<Void, Error> {
        if tasks.contains(where: { $0.id == task.id }) {
            return update(task)
        } else {
            return add(task)
        }
    }
}
