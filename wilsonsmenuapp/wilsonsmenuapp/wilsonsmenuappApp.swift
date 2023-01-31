//
//  wilsonsmenuappApp.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//

import SwiftUI

@main
struct wilsonsmenuappApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
