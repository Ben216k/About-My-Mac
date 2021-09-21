//
//  About_My_MacApp.swift
//  About My Mac
//
//  Created by Ben Sova on 9/20/21.
//

import SwiftUI

@main
struct About_My_MacApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 600, maxWidth: 600, minHeight: 325, maxHeight: 325)
        }.windowStyle(HiddenTitleBarWindowStyle())
        .commands(content: {
            Group {
                CommandGroup(replacing: .newItem) {}
                CommandGroup(replacing: CommandGroupPlacement.importExport) {}
                CommandGroup(replacing: CommandGroupPlacement.appVisibility) {}
                CommandGroup(replacing: CommandGroupPlacement.pasteboard) {}
                CommandGroup(replacing: CommandGroupPlacement.undoRedo) {}
                CommandGroup(replacing: CommandGroupPlacement.textEditing) {}
                CommandGroup(replacing: CommandGroupPlacement.windowArrangement) {}
                CommandGroup(replacing: CommandGroupPlacement.windowList) {}
                CommandGroup(replacing: CommandGroupPlacement.saveItem) {}
                CommandGroup(replacing: CommandGroupPlacement.systemServices) {}
            }
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {}
        })
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 584, height: 346),
            styleMask: [.titled, .miniaturizable, .fullSizeContentView, .borderless],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = true
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }


}
