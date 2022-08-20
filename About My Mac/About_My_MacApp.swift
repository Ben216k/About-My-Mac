//
//  About_My_MacApp.swift
//  About My Mac
//
//  Created by Ben Sova on 9/20/21.
//

import SwiftUI

struct About_My_MacApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var style = AMStyles.bigSur1
    
    var body: some Scene {
        WindowGroup {
            SuperView(style: $style)
                .frame(minWidth: 600, maxWidth: 600, minHeight: 325, maxHeight: 325)
        }.windowStyle(HiddenTitleBarWindowStyle())
//        .commands(content: {
//            Group {
//                CommandGroup(replacing: .newItem) {}
//                CommandGroup(replacing: CommandGroupPlacement.importExport) {}
//                CommandGroup(replacing: CommandGroupPlacement.appVisibility) {}
//                CommandGroup(replacing: CommandGroupPlacement.pasteboard) {}
//                CommandGroup(replacing: CommandGroupPlacement.undoRedo) {}
//                CommandGroup(replacing: CommandGroupPlacement.textEditing) {}
//                CommandGroup(replacing: CommandGroupPlacement.windowArrangement) {}
//                CommandGroup(replacing: CommandGroupPlacement.windowList) {}
//                CommandGroup(replacing: CommandGroupPlacement.saveItem) {}
//                CommandGroup(replacing: CommandGroupPlacement.systemServices) {}
//            }
//            CommandGroup(replacing: CommandGroupPlacement.appInfo) {}
//        })
        Settings {
            PreferencesView(selectedStyle: $style)
                .frame(minWidth: 400, maxWidth: 400, minHeight: 335, maxHeight: 335)
        }.windowStyle(HiddenTitleBarWindowStyle())
    }
}

@available(macOS 13, *)
struct About_My_MacApp13: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var style = AMStyles.bigSur1
    
    var body: some Scene {
        WindowGroup {
            SuperView(style: $style)
                .frame(minWidth: 600, maxWidth: 600, minHeight: 355, maxHeight: 355)
        }.windowStyle(HiddenTitleBarWindowStyle())
            .windowResizability(WindowResizability.contentSize)
//        .commands(content: {
//            Group {
//                CommandGroup(replacing: .newItem) {}
//                CommandGroup(replacing: CommandGroupPlacement.importExport) {}
//                CommandGroup(replacing: CommandGroupPlacement.appVisibility) {}
//                CommandGroup(replacing: CommandGroupPlacement.pasteboard) {}
//                CommandGroup(replacing: CommandGroupPlacement.undoRedo) {}
//                CommandGroup(replacing: CommandGroupPlacement.textEditing) {}
//                CommandGroup(replacing: CommandGroupPlacement.windowArrangement) {}
//                CommandGroup(replacing: CommandGroupPlacement.windowList) {}
//                CommandGroup(replacing: CommandGroupPlacement.saveItem) {}
//                CommandGroup(replacing: CommandGroupPlacement.systemServices) {}
//            }
//            CommandGroup(replacing: CommandGroupPlacement.appInfo) {}
//        })
        Settings {
            PreferencesView(selectedStyle: $style)
                .frame(minWidth: 400, maxWidth: 400, minHeight: 320, maxHeight: 320)
        }.windowStyle(HiddenTitleBarWindowStyle())
            .windowResizability(WindowResizability.contentSize)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 325),
            styleMask: [.titled, .miniaturizable, .fullSizeContentView, .borderless],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = true
        window.styleMask.remove(.resizable)
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
