//
//  StatusBarController.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//

import AppKit


class StatusBarController {
    private var statusBar: NSStatusBar
    private(set) var statusItem: NSStatusItem
    private(set) var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusBar = .init()
        statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        let image = NSImage(systemSymbolName: "pencil.and.outline", accessibilityDescription: nil)
        
        if let button = statusItem.button {
            button.image = image
            button.action = #selector(showApp(sender:))
            button.target = self
        }
    }
    
    @objc
    func showApp(sender: AnyObject) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .minY)
        }
    }
}
