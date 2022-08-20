//
//  DaytoApp.swift
//  Dayto
//
//  Created by Andriy on 20/08/2022.
//

import SwiftUI

@main
struct DaytoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
