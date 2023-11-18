
import SwiftUI

struct HomeView: View {
    
    @State var editing: Bool = false
    @State var edit: Bool = false
    @State var isShaking: Bool = false
    @Environment(\.self) var envi
    @ObservedObject var taskManagerViewModel: TaskManagerViewModel = TaskManagerViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], animation: .easeInOut) var tasks: FetchedResults<Task>
    
    var body: some View {
       NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    DateView(edit: editing)
                    ForEach(tasks) { item in
                        TaskCard(title: item.title ?? "", descriptiont: item.descriptiont ?? "", iconName: item.icon ?? "", colorName: item.color ?? "", dataData: (item.deadline ?? Date()).formatted(date: .long, time: .omitted), dataTime: (item.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                            .overlay(alignment: .bottomTrailing, content: {
                                if editing {
                                    Button(action: {
                                        editing.toggle()
                                        if taskManagerViewModel.removeTask(task: item, context: envi.managedObjectContext) {
                                        }
                                        envi.dismiss()
                                    }, label: {
                                        Image(systemName: "trash")
                                            .font(.title2)
                                            .foregroundColor(.red)
                                            .offset(y: isShaking ? -3 : 3)
                                    })
                                    .padding(5)
                                }
                            })
                    }
                }
            }
            .padding(10)
            .overlay(alignment: .bottom, content: {
                Button(action: {
                    taskManagerViewModel.restartText()
                    taskManagerViewModel.newTaskView.toggle()
                }, label: {
                    Text("New task")
                        .foregroundColor(Color(.yellow)) //(Color("toggle"))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 40)
                        .background(.black, in: Capsule())
                })
                
            })
            .sheet(isPresented: $taskManagerViewModel.newTaskView, content: {
                AddTaskView()
                    .environmentObject(taskManagerViewModel)
            })
            
        }
        .navigationBarItems(leading: Button(action: {
            editing.toggle()
            withAnimation( Animation.default.speed(2).repeatForever(autoreverses: true).delay(2)) {
                self.isShaking.toggle()
            }
            
        }, label: {
            Image(systemName: "paperclip.circle") //square.and.pencil.circle.fill
                .font(.title2)
                .foregroundColor(.yellow)
        }))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
