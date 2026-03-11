//
//  DevilFruitCollector.swift
//  DevilFruitCollector
//
//  Created by Osman Kahraman on 2025-11-11.
//

import SwiftUI

@main
struct DevilFruitCollector: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
