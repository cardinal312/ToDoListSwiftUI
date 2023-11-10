//
//  TaskManagerSwiftUIApp.swift
//  TaskManagerSwiftUI
//
//  Created by Macbook on 10/11/23.
//

import SwiftUI

@main
struct TaskManagerSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
