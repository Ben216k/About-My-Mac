//
//  SuperView.swift
//  About My Mac
//
//  Created by Ben Sova on 8/19/22.
//

import SwiftUI

struct SuperView : View {
    
    @State var page = ViewPages.main
    @Binding var style: AMStyles
    @Environment(\.colorScheme) var colorScheme
    @State var systemVersion = "10.%.3"
    let releaseTrack: String
    @State var gpu = "Intel HD Graphics 400%"
    @State var coolModel = "MacBook Pro (13-inch, M%d 2012)" as String?
    @State var model = "MacBookPro%,2"
    @State var cpu = "Intel(R) Core(TM) i5-3210M CPU"
    @State var memory = "1%"
    @State var buildNumber = "20xxyyzz"
    @State var hovered: String?
    @State var showTheBar = false
    @Binding var backgroundBlur: Bool
    
    var body: some View {
        ZStack {
            Text(" ")
                .onAppear {
                    self.backgroundBlur = UserDefaults.standard.bool(forKey: "BlurBG")
                    self.buildNumber = (try? call("system_profiler SPSoftwareDataType | grep 'System Version' | cut -c 29- | awk '{print $2}'")) ?? "(20xyyzzz)"
                    // print buildNumber and background blur configuration
                    if self.buildNumber.hasPrefix("(") { self.buildNumber.removeFirst() }
                    if self.buildNumber.hasSuffix(")") { self.buildNumber.removeLast() }
                    print("Build number detected \(self.buildNumber) (\(self.buildNumber.count))")
                    self.style = AMStyles(rawValue: UserDefaults.standard.string(forKey: "Style") ?? "BigSur1") ?? .bigSur1
                    systemVersion = (try? call("sw_vers -productVersion")) ?? "12.xx.yy"
                    sysVersion = systemVersion
                    print("Detected System Version: \(systemVersion)")
                    DispatchQueue.global(qos: .background).async {
                        self.model = (try? call("sysctl -n hw.model")) ?? "UnknownX,Y"
                        cpu = (try? call("sysctl -n machdep.cpu.brand_string")) ?? "INTEL!"
                        gpu = (try? call("system_profiler SPDisplaysDataType | awk -F': ' '/^\\ *Chipset Model:/ {printf $2 \", \"}'")) ?? "INTEL!"
                        if gpu.count <= 2 {
                            gpu = "No GPU Detected.."
                        }
                        gpu.removeLast(2)
                        print("Detected GPU: \(gpu)")
                        memory = (try? call("echo \"$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))\"")) ?? "-100"
                        print("Detected Memory Amount: \(memory)")
                        let cpuShim = cpu.split(separator: "@")
                        cpu = cpuShim.count > 0 ? String(cpuShim[0]) : cpu
                        if cpu.isEmpty {
                            cpu = (try? call("sysctl -n machdep.cpu.brand_string")) ?? "INTEL!"
                        }
                        print("Detected CPU: \(cpu)")
                        var newModel = getMacName(infoString: self.model) as String?
                        if newModel == "Mac" {
                            guard let newNewModel = try? call("curl -s 'https://support-sp.apple.com/sp/product?cc='$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-) | sed 's|.*<configCode>\\(.*\\)</configCode>.*|\\1|'") else {
                                coolModel = nil
                                return
                            }
                            if newNewModel.hasPrefix("<") {
                                newModel = nil
                            } else {
                                print("If you're reading this, you might want to report this as a bug and post it on the GitHub repo.")
                                newModel = newNewModel
                            }
                        }
                        coolModel = newModel
                    }
                }
            switch page {
            case .main:
                ContentView(systemVersion: $systemVersion, releaseTrack: releaseTrack, gpu: $gpu, coolModel: $coolModel, model: $model, cpu: $cpu, memory: $memory, buildNumber: $buildNumber, hovered: $hovered, style: $style, page: $page, backgroundBlur: $backgroundBlur)
                    .transition(.move(edge: .leading))
            case .storage:
                StorageView()
                    .transition(.asymmetric(insertion: .moveAway, removal: .moveAwayR))
            }
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .foregroundColor(colorScheme == .light ? Color("ReversedPrimary") : Color(white: 0.2))
                        .cornerRadius(11)
                        .shadow(color: colorScheme == .light ? Color.black.opacity(0.2) : Color.black.opacity(0.5), radius: 5, y: 3)
                    Rectangle()
                        .foregroundColor(colorScheme == .light ?  .secondary.opacity(0.1) : Color(white: 0.1))
                        .cornerRadius(9)
                        .padding(8)
                    HStack(spacing: 0) {
                        Button {
                            withAnimation {
                                page = .main
                            }
                        } label: {
                            Text("Overview")
                                .foregroundColor(.primary)
                                .padding(7.5)
                                .padding(.horizontal, 4)
                                .background(page == .main ? Color(white: colorScheme == .dark ? 0.175 : 1).cornerRadius(7) : Color.clear.cornerRadius(7))
                                .shadow(color: page == .main ? Color.black.opacity(0.15) : Color.clear, radius: 3)
                        }.buttonStyle(.borderless)
                        Button {
                            withAnimation {
                                page = .storage
                            }
                        } label: {
                            Text("Storage")
                                .foregroundColor(.primary)
                                .padding(7.5)
                                .padding(.horizontal, 4)
                                .background(page == .storage ? Color(white: colorScheme == .dark ? 0.175 : 1).cornerRadius(7) : Color.clear.cornerRadius(7))
                                .shadow(color: page == .storage ? Color.black.opacity(0.15) : Color.clear, radius: 3)
                        }.buttonStyle(.borderless)
                        
                    }.padding(4)
                        .padding(8)
                }.foregroundColor(.primary)
                    .fixedSize().padding(15)
                    .offset(y: page != .main || showTheBar ? 0 : 75)
                    .onHover { hover in
                        withAnimation {
                            if hover && (page != .main) {
                                showTheBar = true
                            } else if !hover {
                                showTheBar = false
                            }
                        }
                    }
            }
        }
    }
    
    init(style: Binding<AMStyles>, backgroundBlur: Binding<Bool>) {
        print("Helllooo!")
        self._backgroundBlur = backgroundBlur
        self._style = style
        self.releaseTrack = "Release"
//        self.buildNumber.removeLast()
        print("Detected macOS Build Number: \(buildNumber)")
    }
}

enum ViewPages: Int {
    case main
    case storage
}

extension AnyTransition {
    static var moveAway: AnyTransition {
        return .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
    static var moveAwayR: AnyTransition {
        return .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    }
    static var moveAway2: AnyTransition {
        return AnyTransition.asymmetric(insertion: AnyTransition.modifier(active: InsertItem(a: false), identity: InsertItem(a: true)), removal: AnyTransition.modifier(active: DeleteItem(a: false), identity: DeleteItem(a: true)))
    }
}

struct InsertItem: ViewModifier {
    let a: Bool
    func body(content: Content) -> some View {
        content
            .offset(x: a ? 0 : 200, y: 0)
            .opacity(a ? 1 : 0)
    }
}

struct DeleteItem: ViewModifier {
    let a: Bool
    func body(content: Content) -> some View {
        content
            .offset(x: a ? 0 : -100, y: 0)
            .opacity(a ? 1 : 0)
    }
}
