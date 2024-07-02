//
//  VisualEffectView.swift
//  About My Mac
//
//  Created by Ben Sova on 3/9/24.
//

import Foundation
import SwiftUI

struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode
    var state: NSVisualEffectView.State = .active

    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        // You can adjust the state to be active or follow the window's active state
        view.state = state
        return view
    }

    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.state = state
    }
}

struct BlurView: NSViewRepresentable {
    var radius: CGFloat

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.wantsLayer = true
        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": radius])
        view.layer?.backgroundFilters = [blurFilter].compactMap { $0 }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": radius])
        nsView.layer?.backgroundFilters = [blurFilter].compactMap { $0 }
    }
}
