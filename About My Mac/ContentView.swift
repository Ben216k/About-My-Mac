//
//  ContentView.swift
//  About My Mac
//
//  Created by Ben Sova on 9/20/21.
//

import VeliaUI

struct ContentView: View {
    @State var systemVersion = "11.%.3"
    let releaseTrack: String
    @State var gpu = "Intel HD Graphics 400%"
    @State var coolModel = "MacBook Pro (13-inch, M%d 2012)" as String?
    @State var model = "MacBookPro%,2"
    @State var cpu = "Intel(R) Core(TM) i5-3210M CPU"
    @State var memory = "1%"
    @State var buildNumber: String
    @State var hovered: String?
    
    var body: some View {
        ZStack {
            BackGradientView(version: systemVersion, releaseTrack: releaseTrack)
            HStack {
                SideImageView(releaseTrack: releaseTrack, version: systemVersion)
                VStack(alignment: .leading, spacing: 2) {
                    if systemVersion.hasPrefix("12") {
                        Text("macOS ").font(.largeTitle).bold() + Text("Monterey").font(.largeTitle)
                    } else {
                        Text("macOS ").font(.largeTitle).bold() + Text("Big Sur").font(.largeTitle)
                    }
                    Text("\(NSLocalizedString("PO-AMM-VERSION", comment: "PO-AMM-VERSION")) \(systemVersion)\(buildNumber.count < 8 ? "" : " Beta") (\(buildNumber))").font(.subheadline)
                        .redacted(reason: systemVersion.contains("%") ? .placeholder : .init())
                    Rectangle().frame(height: 10).opacity(0).fixedSize()
                    if let coolModel = coolModel {
                        Text(coolModel).font(.subheadline).bold()
                            .redacted(reason: coolModel.contains("%") ? .placeholder : .init())
                    }
                    HStack(spacing: 10) {
                        VStack(alignment: .leading) {
                            Text(.init("PO-AMM-MODEL")).font(.subheadline).bold()
                            Text(.init("PO-AMM-PROCESSOR")).font(.subheadline).bold()
                            Text(.init("PO-AMM-GRAPHICS")).font(.subheadline).bold()
                            Text(.init("PO-AMM-MEMORY")).bold()
                        }
                        VStack(alignment: .leading) {
                            Text(model)
                                .redacted(reason: model.contains("%") ? .placeholder : .init())
                            Text(cpu)
                                .redacted(reason: cpu.contains("%") ? .placeholder : .init())
                            Text(gpu)
                                .redacted(reason: gpu.contains("%") ? .placeholder : .init())
                            Text("\(memory) GB")
                                .redacted(reason: memory.contains("%") ? .placeholder : .init())
                        }
                    }
                    HStack {
                        VIButton(id: "HOME", h: $hovered) {
                            Text(.init("PO-AMM-REPORT"))
                                .foregroundColor(.white)
                        } onClick: {
                            _ = try? call("open -a 'System Information'")
                        }.inPad()
                            .btColor(releaseTrack == "Developer" || systemVersion.hasPrefix("12") ? .init(r: 196, g: 0, b: 255) : .init(r: 0, g: 220, b: 239))
                        VIButton(id: "SOFTWARE", h: $hovered) {
                            Text(.init("PO-AMM-UPDATE"))
                                .foregroundColor(.white)
                        } onClick: {
                            if (try? call("[ -d /Applications/Patched\\ Sur.app ]")) != nil {
                                NSWorkspace.shared.open(URL(string: "patched-sur://run-updates")!)
                            } else {
                                NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preferences.softwareupdate")!)
                            }
                        }.inPad()
                        .btColor(releaseTrack == "Developer" || systemVersion.hasPrefix("12") ? .init(r: 196, g: 0, b: 255) : .init(r: 0, g: 220, b: 239))
                    }.padding(.top, 10)
                }.font(.subheadline)
                .foregroundColor(.white)
                .onAppear {
                    systemVersion = (try? call("sw_vers -productVersion")) ?? "11.xx.yy"
                    print("Detected System Version: \(systemVersion)")
                    self.model = (try? call("sysctl -n hw.model")) ?? "UnknownX,Y"
                    cpu = (try? call("sysctl -n machdep.cpu.brand_string")) ?? "INTEL!"
                    cpu = String(cpu.split(separator: "@")[0])
                    print("Detected CPU: \(cpu)")
                    gpu = (try? call("system_profiler SPDisplaysDataType | awk -F': ' '/^\\ *Chipset Model:/ {printf $2 \", \"}'")) ?? "INTEL!"
                    gpu.removeLast(2)
                    print("Detected GPU: \(gpu)")
                    memory = (try? call("echo \"$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))\"")) ?? "-100"
                    print("Detected Memory Amount: \(memory)")
                    _ = try? call("curl -s 'https://support-sp.apple.com/sp/product?cc='$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-) | sed 's|.*<configCode>\\(.*\\)</configCode>.*|\\1|'")
                    DispatchQueue.global(qos: .background).async {
                        guard let newModel = try? call("curl -s 'https://support-sp.apple.com/sp/product?cc='$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-) | sed 's|.*<configCode>\\(.*\\)</configCode>.*|\\1|'") else {
                            coolModel = nil
                            return
                        }
                        coolModel = newModel
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }.ignoresSafeArea()
    }
    
    init() {
        self.releaseTrack = "Release"
        self.buildNumber = (try? call("sw_vers | grep BuildVersion: | cut -c 15-")) ?? "20xyyzzz"
        print("Detected macOS Build Number: \(buildNumber)")
    }
}

extension Color {
    init(
        r red: Int,
        g green: Int,
        b blue: Int,
        o opacity: Double = 1
    ) {
        self.init(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: opacity
        )
    }
}

struct SideImageView: View {
    let version: String
    let releaseTrack: String
    let scale: CGFloat
    var body: some View {
        if version.hasPrefix("12")  {
            Image("PMStock")
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .frame(width: scale, height: scale)
                .padding()
        } else if releaseTrack == "Beta" || releaseTrack == "Developer" {
            Image("BigSurLake")
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .frame(width: scale, height: scale)
                .padding()
        } else {
            Image("BigSurSafari")
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .frame(width: scale, height: scale)
                .padding()
        }
    }
    
    init(releaseTrack: String, scale: CGFloat = 140, version: String = "") {
        self.releaseTrack = releaseTrack
        self.scale = scale
        self.version = version
    }
}

struct BackGradientView: View {
    @Environment(\.colorScheme) var colorScheme
    let version: String
    let releaseTrack: String
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    var body: some View {
        Group {
            if releaseTrack == "Developer" || version.hasPrefix("12") {
                LinearGradient(gradient: .init(colors: [.init(r: 196, g: 0, b: 255), .init(r: 117, g: 0, b: 255)]), startPoint: startPoint, endPoint: endPoint)
                    .opacity(colorScheme == .dark ? 0.7 : 0.96)
                    .onAppear {
                        withAnimation (.easeInOut(duration: 5).repeatForever()) {
                            self.startPoint = UnitPoint(x: 1, y: -1)
                            self.endPoint = UnitPoint(x: 0, y: 1)
                        }
                    }
            } else {
                LinearGradient(gradient: .init(colors: [.init(r: 0, g: 220, b: 239), .init(r: 5, g: 229, b: 136)]), startPoint: startPoint, endPoint: endPoint)
                    .opacity(colorScheme == .dark ? 0.7 : 0.96)
                    .background(Color.black)
                    .onAppear {
                        withAnimation (.easeInOut(duration: 5).repeatForever()) {
                            self.startPoint = UnitPoint(x: 1, y: -1)
                            self.endPoint = UnitPoint(x: 0, y: 1)
                        }
                    }
            }
        }
    }
}
