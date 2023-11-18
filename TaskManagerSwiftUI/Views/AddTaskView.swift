//
//  AddTaskView.swift
//  TaskManagerSwiftUI
//
//  Created by Macbook on 16/11/23.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskManagerViewModel: TaskManagerViewModel
    @Environment(\.self) var envi
    let colors: [String] = ["yellow", "green", "red", "pink", "purple"]
    let icons: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
        VStack {
            Text("New Task")
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading, content: {
                    Button(action: {
                        envi.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.red)
                        
                    })
                })
            VStack(alignment: .leading, spacing: 10) {
                BarColor(section: "Colors", colors: colors, taskManagerViewModel: _taskManagerViewModel)
                Icons(section: "Icons", icons: icons, taskManagerViewModel: _taskManagerViewModel)
                Divider()
                HStack {
                    Text(taskManagerViewModel.taskDeadLine.formatted(date: .abbreviated, time: .omitted) + ", " + taskManagerViewModel.taskDeadLine.formatted(date: .omitted, time: .shortened))
                        .padding(10)
                    Spacer()
                    Button(action: {
                        taskManagerViewModel.showDataPicker.toggle()
                    }, label: {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("whiteDark"))
                            .padding(10)
                    })
                }
                Divider()
                TextFieldTitle(typing: $taskManagerViewModel.taskTitle, title: "Title")
                Divider()
                TextFieldTitle(typing: $taskManagerViewModel.taskDescription, title: "Description")
            }
            .padding(.vertical, 30)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if taskManagerViewModel.showDataPicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            taskManagerViewModel.showDataPicker = false
                        }
                    DatePicker("", selection: $taskManagerViewModel.taskDeadLine, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(Color("toggle"), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                    
                    
                    
                }
            }
        }
        .overlay(alignment: .bottom, content: {
            Button(action: {
                if !taskManagerViewModel.taskTitle.isEmpty || !taskManagerViewModel.taskDescription.isEmpty {
                    if taskManagerViewModel.addNewTask(context: envi.managedObjectContext) {
                        envi.dismiss()
                    }
                }
                
            }, label: {
                Text("Save")
                    .foregroundColor(Color(.yellow)) //(Color("toggle"))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 60)
                    .background(Color("whiteDark"), in: Capsule())
                
            })
            .padding(.bottom, 30)
        })
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TaskManagerViewModel())
    }
}

struct BarColor: View {
    var section = ""
    let colors: [String]
    @EnvironmentObject var taskManagerViewModel: TaskManagerViewModel
    
    var body: some View {
        Text(section)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(Color(color))
                        .frame(width: 25, height: 25)
                        .background(content: {
                            if taskManagerViewModel.taskColor == color {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                        })
                        .onTapGesture {
                            taskManagerViewModel.taskColor = color
                        }
                }
            }
            .padding()
        }
    }
}

struct Icons: View {
    
    var section = ""
    let icons: [String]
    @EnvironmentObject var taskManagerViewModel: TaskManagerViewModel
    
    var body: some View {
        Text(section)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(icons, id: \.self) { icon in
                    Image(icon)
                        .resizable()
                        .clipShape(Rectangle())
                        .frame(width: 25, height: 25)
                        .background(content: {
                            if taskManagerViewModel.taskIcon == icon {
                                Rectangle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                            }
                        })
                        .onTapGesture {
                            taskManagerViewModel.taskIcon = icon
                        }
                }
            }
            .padding(10)
        }
    }
}

struct TextFieldTitle: View {
    
    @Binding var typing: String
    var title: String = ""
    
    var body: some View {
        TextField(title, text: $typing)
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.gray.opacity(0.3).cornerRadius(5))
            .foregroundColor(Color("whiteDark"))
    }
}
