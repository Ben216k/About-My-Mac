//
//  ContentView.swift
//  About My Mac
//
//  Created by Ben Sova on 9/20/21.
//

import VeliaUI

struct ContentView: View {
    @State var systemVersion = "10.%.3"
    let releaseTrack: String
    @State var gpu = "Intel HD Graphics 400%"
    @State var coolModel = "MacBook Pro (13-inch, M%d 2012)" as String?
    @State var model = "MacBookPro%,2"
    @State var cpu = "Intel(R) Core(TM) i5-3210M CPU"
    @State var memory = "1%"
    @State var buildNumber: String
    @State var hovered: String?
    @Binding var style: AMStyles
    
    var body: some View {
        ZStack {
            BackGradientView(version: systemVersion, releaseTrack: releaseTrack, style: style)
            HStack {
                SideImageView(releaseTrack: releaseTrack, version: systemVersion, style: style)
                VStack(alignment: .leading, spacing: 2) {
                    if systemVersion.hasPrefix("13") {
                        Text("macOS ").font(.largeTitle).bold() + Text("Ventura").font(.largeTitle)
                    } else if systemVersion.hasPrefix("12") {
                        Text("macOS ").font(.largeTitle).bold() + Text("Monterey").font(.largeTitle)
                    } else {
                        Text("macOS ").font(.largeTitle).bold() + Text("Big Sur").font(.largeTitle)
                    }
                    Text("\(NSLocalizedString("PO-AMM-VERSION", comment: "PO-AMM-VERSION")) \(systemVersion)\(buildNumber.count < 8 ? "" : " Beta") \(buildNumber)").font(.subheadline)
                        .redacted(reason: systemVersion.contains("%") ? .placeholder : .init())
                    Rectangle().frame(height: 10).opacity(0).fixedSize()
                    if let coolModel = coolModel {
                        Text(coolModel).font(.subheadline).bold()
                            .redacted(reason: coolModel.contains("%") ? .placeholder : .init())
                    }
                    HStack(spacing: 10) {
                        VStack(alignment: .leading) {
                            Text(.init("PO-AMM-MODEL")).font(.subheadline).bold()
                            if cpu != gpu {
                                Text(.init("PO-AMM-PROCESSOR")).font(.subheadline).bold()
                                Text(.init("PO-AMM-GRAPHICS")).font(.subheadline).bold()
                            } else {
                                Text(.init("PO-AMM-CHIP")).font(.subheadline).bold()
                            }
                            Text(.init("PO-AMM-MEMORY")).bold()
                        }
                        VStack(alignment: .leading) {
                            Text(model)
                                .redacted(reason: model.contains("%") ? .placeholder : .init())
                            Text(cpu)
                                .redacted(reason: cpu.contains("%") ? .placeholder : .init())
                            if cpu != gpu {
                                Text(gpu)
                                    .redacted(reason: gpu.contains("%") ? .placeholder : .init())
                            }
                            Text("\(memory) GB")
                                .redacted(reason: memory.contains("%") ? .placeholder : .init())
                        }
                    }
                    HStack {
                        VIButtonBlend(id: "HOME", h: $hovered) {
                            Text(.init("PO-AMM-REPORT"))
                                .foregroundColor(.white)
                        } onClick: {
                            _ = try? call("open -a 'System Information'")
                        }.inPad()
                            .btColor(systemVersion.hasPrefix("12") ? .init(r: 196, g: 0, b: 255) : (systemVersion.hasPrefix("13") ? .init(r: 255, g: 187, b: 0).opacity(0.8) : .init(r: 0, g: 220, b: 239)))
                        VIButtonBlend(id: "SOFTWARE", h: $hovered) {
                            Text(.init("PO-AMM-UPDATE"))
                                .foregroundColor(.white)
                        } onClick: {
                            if (try? call("[ -d /Applications/Patched\\ Sur.app ]")) != nil {
                                NSWorkspace.shared.open(URL(string: "patched-sur://run-updates")!)
                            } else {
                                NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preferences.softwareupdate")!)
                            }
                        }.inPad()
                            .btColor(systemVersion.hasPrefix("12") ? .init(r: 196, g: 0, b: 255) : (systemVersion.hasPrefix("13") ? .init(r: 255, g: 187, b: 0).opacity(0.8) : .init(r: 0, g: 220, b: 239)))
                    }.padding(.top, 10)
                }.font(.subheadline)
                .foregroundColor(.white)
                .onAppear {
                    self.style = AMStyles(rawValue: UserDefaults.standard.string(forKey: "Style") ?? "BigSur1") ?? .bigSur1
                    #if RELEASE
                    systemVersion = (try? call("sw_vers -productVersion")) ?? "11.xx.yy"
                    #else
                    systemVersion = "13.xx.yy"
                    #endif
                    sysVersion = systemVersion
                    print("Detected System Version: \(systemVersion)")
                    self.model = (try? call("sysctl -n hw.model")) ?? "UnknownX,Y"
                    cpu = (try? call("sysctl -n machdep.cpu.brand_string")) ?? "INTEL!"
                    cpu = String(cpu.split(separator: "@")[0])
                    print("Detected CPU: \(cpu)")
                    gpu = (try? call("system_profiler SPDisplaysDataType | awk -F': ' '/^\\ *Chipset Model:/ {printf $2 \", \"}'")) ?? "INTEL!"
                    if gpu.count <= 2 {
                        gpu = "No GPU Detected.."
                    }
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
    
    init(style: Binding<AMStyles>) {
        print("Helllooo!")
        self._style = style
        self.releaseTrack = "Release"
        self.buildNumber = (try? call("system_profiler SPSoftwareDataType | grep 'System Version' | cut -c 29- | awk '{print $2}'")) ?? "20xyyzzz"
//        self.buildNumber.removeLast()
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
    @Environment(\.colorScheme) var colorScheme
    let version: String
    let releaseTrack: String
    let scale: CGFloat
    var style: AMStyles
    
    var body: some View {
        if version.hasPrefix("13")  {
            ZStack {
                if style == .venDark || style == .venBlue {
                    Circle()
                        .foregroundColor(style == .venDark ? .init(r: 172, g: 73, b: 55) : .init(r: 1, g: 48, b: 120))
                        .blendMode(.normal)
                    Image(style == .venDark ? "VenturaFluff" : "BlueFluff")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .preferredColorScheme(.dark)
                        .cornerRadius(100)
                        .padding(8)
                } else {
                    Circle()
                        .foregroundColor(.init(r: 210, g: 210, b: 210))
                        .blendMode(.multiply)
                    Image("VenturaFluff")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .preferredColorScheme(.light)
                        .cornerRadius(100)
                        .padding(8)
                }
            }.frame(width: scale, height: scale)
                .padding()
        } else if version.hasPrefix("12")  {
            if style == .pink {
                ZStack {
                    Circle()
                        .foregroundColor(.init(r: 200, g: 200, b: 200))
                        .blendMode(.multiply)
                    Image("MontereyLight")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(100)
                        .padding(8)
                }.frame(width: scale, height: scale)
                    .padding()
            } else {
                Image("PMStock")
                    .interpolation(.high)
                    .resizable()
                    .scaledToFit()
                    .frame(width: scale, height: scale)
                    .padding()
            }
        } else {
            if style == .mario {
                ZStack {
                    Circle()
                        .foregroundColor(.init(r: 200, g: 200, b: 200))
                        .blendMode(.multiply)
                    Image("BigSurThing")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(100)
                        .padding(8)
                }.frame(width: scale, height: scale)
                    .padding()
            } else if style == .water {
                ZStack {
                    Circle()
                        .foregroundColor(.init(r: 200, g: 200, b: 200))
                        .blendMode(.multiply)
                    Image("BigSurLake")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(100)
                        .padding(8)
                }.frame(width: scale, height: scale)
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
    }
    
    init(releaseTrack: String, scale: CGFloat = 140, version: String = "", style: AMStyles) {
        self.releaseTrack = releaseTrack
        self.scale = scale
        self.version = version
        self.style = style
    }
}

struct BackGradientView: View {
    @Environment(\.colorScheme) var colorScheme
    let version: String
    let releaseTrack: String
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    @State var lstartPoint = UnitPoint(x: 0, y: 0)
    @State var lendPoint = UnitPoint(x: -0.1, y: 0.8)
    var style: AMStyles
    
    var body: some View {
        Group {
            if version.hasPrefix("13") {
                ZStack {
                    if style == .venDark {
                        LinearGradient(gradient: .init(colors: [.init("13DA"), .init("13DB")]), startPoint: startPoint, endPoint: endPoint)
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7.5).repeatForever().delay(2)) {
                                    self.endPoint = UnitPoint(x: 1.5, y: 1)
                                    self.startPoint = UnitPoint(x: 0.5, y: 1.75)
//                                    self.lendPoint = UnitPoint(x: 0.9, y: 0.75)
//                                    self.lstartPoint = UnitPoint(x: 0, y: 1)
                                }
                            }.blendMode(.normal)
                    } else if style == .venBlue {
                        LinearGradient(gradient: .init(colors: [.init("13D1"), .init("13D2")]), startPoint: startPoint, endPoint: endPoint)
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7.5).repeatForever().delay(2)) {
                                    self.endPoint = UnitPoint(x: 1.5, y: 1)
                                    self.startPoint = UnitPoint(x: 0.5, y: 1.75)
//                                    self.lendPoint = UnitPoint(x: 0.9, y: 0.75)
//                                    self.lstartPoint = UnitPoint(x: 0, y: 1)
                                }
                            }.blendMode(.normal)
                    } else {
                        LinearGradient(gradient: .init(colors: [.init("13LA"), .init("13LB")]), startPoint: lstartPoint, endPoint: lendPoint)
                            .blendMode(.normal)
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7.5).repeatForever().delay(2)) {
//                                    self.endPoint = UnitPoint(x: 1.5, y: 1)
//                                    self.startPoint = UnitPoint(x: 0.5, y: 1.75)
                                    self.lendPoint = UnitPoint(x: 0.9, y: 0.75)
                                    self.lstartPoint = UnitPoint(x: 0, y: 1)
                                }
                            }.blendMode(.normal)
                    }
                }
            } else if version.hasPrefix("12") {
                if style == .monterey2 {
                    LinearGradient(gradient: .init(colors: [.init("MontereyA1"), .init("MontereyA2")]), startPoint: startPoint, endPoint: endPoint)
                        .blendMode(.normal)
                        .opacity(colorScheme == .dark ? 0.7 : 0.96)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -1)
                                self.endPoint = UnitPoint(x: 0, y: 1)
                            }
                        }
                } else if style == .pink {
                    LinearGradient(gradient: .init(colors: [.init("P1NK"), .init("P2NK")]), startPoint: startPoint, endPoint: endPoint)
                        .blendMode(.normal)
                        .opacity(colorScheme == .dark ? 0.7 : 0.96)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -1)
                                self.endPoint = UnitPoint(x: 0, y: 1)
                            }
                        }
                } else {
                    LinearGradient(gradient: .init(colors: [.init(r: 193, g: 0, b: 214), .init(r: 74, g: 0, b: 235)]), startPoint: startPoint, endPoint: endPoint)
                        .blendMode(.normal)
                        .opacity(colorScheme == .dark ? 0.7 : 0.96)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -1)
                                self.endPoint = UnitPoint(x: 0, y: 1)
                            }
                        }
                }
            } else if version.hasPrefix("11") {
                if style == .mario {
                    LinearGradient(gradient: .init(colors: [.init("Mario1"), .init("Mario2")]), startPoint: startPoint, endPoint: endPoint)
                        .opacity(colorScheme == .dark ? 1 : 1)
                        .blendMode(.normal)
                    //                    .background(Color.black)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -0.5)
                                self.endPoint = UnitPoint(x: 0.5, y: 1)
                            }
                        }
                } else if style == .lime {
                    LinearGradient(gradient: .init(colors: [.init("BSLime1"), .init("BSLime2")]), startPoint: startPoint, endPoint: endPoint)
                        .opacity(colorScheme == .dark ? 1 : 1)
                        .blendMode(.normal)
                    //                    .background(Color.black)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -0.5)
                                self.endPoint = UnitPoint(x: 0.5, y: 1)
                            }
                        }
                } else if style == .water {
                    LinearGradient(gradient: .init(colors: [.init("BSWater1"), .init("BSWater2")]), startPoint: startPoint, endPoint: endPoint)
                        .opacity(colorScheme == .dark ? 1 : 1)
                        .blendMode(.normal)
                    //                    .background(Color.black)
                        .onAppear {
                            withAnimation (.easeInOut(duration: 5).repeatForever()) {
                                self.startPoint = UnitPoint(x: 1, y: -0.5)
                                self.endPoint = UnitPoint(x: 0.5, y: 1)
                            }
                        }
                } else {
                    LinearGradient(gradient: .init(colors: [.init(r: 0, g: 220, b: 239), .init(r: 5, g: 229, b: 136)]), startPoint: startPoint, endPoint: endPoint)
                        .opacity(colorScheme == .dark ? 0.7 : 0.9)
                        .blendMode(.normal)
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
}
var sysVersion = "11.xx.yy"
