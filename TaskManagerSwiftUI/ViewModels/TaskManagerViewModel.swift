
import Foundation
import CoreData

final class TaskManagerViewModel: ObservableObject {
    
    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var taskIcon: String = ""
    @Published var taskColor: String = ""
    @Published var taskDeadLine: Date = Date()
    @Published var showDataPicker: Bool = false
    @Published var newTaskView: Bool = false
    
    func addNewTask(context: NSManagedObjectContext) -> Bool {
        let newTask = Task(context: context)
        newTask.title = taskTitle
        newTask.descriptiont = taskDescription
        newTask.icon = taskIcon
        newTask.color = taskColor
        newTask.deadline = taskDeadLine
        
        do {
            try context.save()
            return true
        } catch {
            print("Error saving context: \(error)")
            return false
        }
    }
    
    func removeTask(task: Task ,context: NSManagedObjectContext) -> Bool {
        context.delete(task)
        do {
            try context.save()
            return true
        } catch {
            print("Context deleting error: \(error)")
            return false
        }
    }
    
    func restartText() {
        taskTitle = ""
        taskDescription = ""
        taskIcon = ""
        taskColor = ""
        taskDeadLine = Date()
    }
}
