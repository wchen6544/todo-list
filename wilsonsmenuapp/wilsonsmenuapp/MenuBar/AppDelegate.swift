//
//  AppDelegate.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    static var popover = NSPopover()
    var statusBar: StatusBarController?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        Self.popover.contentViewController = NSHostingController(rootView: PopoverView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext))
        
        // when the user clicks out of the popover, it will disappear
        Self.popover.behavior = .transient
        Self.popover.animates = false
        
        
        statusBar = StatusBarController(Self.popover)
        
    }
    
}
