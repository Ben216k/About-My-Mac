//
//  ContentView.swift
//  About My Mac
//
//  Created by Ben Sova on 9/20/21.
//

import VeliaUI

struct ContentView: View {
    @Binding var systemVersion: String
    let releaseTrack: String
    @Binding var gpu: String
    @Binding var coolModel: String?
    @Binding var model: String
    @Binding var cpu: String
    @Binding var memory: String
    @Binding var buildNumber: String
    @Binding var hovered: String?
    @Binding var style: AMStyles
    @Binding var page: ViewPages
    
    var body: some View {
        ZStack(alignment: .bottom) {
            BackGradientView(version: systemVersion, releaseTrack: releaseTrack, style: style)
            HStack {
                SideImageView(releaseTrack: releaseTrack, version: systemVersion, style: style)
                VStack(alignment: .leading, spacing: 2) {
                    if systemVersion.hasPrefix("14") {
                        Text("macOS ").font(.largeTitle).bold() + Text("Sonoma").font(.largeTitle)
                    } else if systemVersion.hasPrefix("13") {
                        Text("macOS ").font(.largeTitle).bold() + Text("Ventura").font(.largeTitle)
                    } else if systemVersion.hasPrefix("12") {
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
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack(alignment: .bottom) {
//                (Text("About My Mac ").font(.system(size: 12)).bold() + Text("v\(AppInfo.version) (\(AppInfo.build))").font(.system(size: 10)).fontWeight(.light))
//                    .foregroundColor(.white)
//                    .padding(15)
//                    .padding(.horizontal, 2.5)
                Spacer()
//                Button {
//                    withAnimation {
//                        page = .storage
//                    }
//                } label: {
//                    Image(systemName: "chevron.right.square.fill")
//                        .font(.title2.bold())
//                        .foregroundColor(.white)
//                        .padding(15)
//                }.buttonStyle(.borderless)
            }
        }.ignoresSafeArea()
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
        if version.hasPrefix("14")  {
            ZStack {
                Circle()
                    .foregroundColor(style == .sonDark ? .init("14DR") : .init("14LR"))
                    .blendMode(.normal)
                Image(style == .sonDark ? "SonomaDark" : "SonomaLight")
                    .interpolation(.high)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(100)
                    .padding(8)
            }.frame(width: scale, height: scale)
                .padding()
        } else if version.hasPrefix("13")  {
            ZStack {
                if style == .venDark || style == .venBlue {
                    Circle()
                        .foregroundColor(style == .venDark ? .init(r: 172, g: 73, b: 55) : .init(r: 1, g: 48, b: 120))
                        .blendMode(.normal)
                    Image(style == .venDark ? "VenturaFluffDark" : "BlueFluff")
                        .interpolation(.high)
                        .resizable()
                        .scaledToFit()
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
            if version.hasPrefix("14") {
                ZStack {
                    if style == .sonDark {
                        LinearGradient(gradient: .init(colors: [.init("14D1"), .init("14D2")]), startPoint: startPoint, endPoint: endPoint)
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7.5).repeatForever().delay(2)) {
                                    self.endPoint = UnitPoint(x: 1.5, y: 1)
                                    self.startPoint = UnitPoint(x: 0.5, y: 1.75)
//                                    self.lendPoint = UnitPoint(x: 0.9, y: 0.75)
//                                    self.lstartPoint = UnitPoint(x: 0, y: 1)
                                }
                            }.blendMode(.normal)
                    } else {
                        LinearGradient(gradient: .init(colors: [.init("14L1"), .init("14L2")]), startPoint: startPoint, endPoint: endPoint)
                            .onAppear {
                                withAnimation (.easeInOut(duration: 7.5).repeatForever().delay(2)) {
                                    self.endPoint = UnitPoint(x: 1.5, y: 1)
                                    self.startPoint = UnitPoint(x: 0.5, y: 1.75)
//                                    self.lendPoint = UnitPoint(x: 0.9, y: 0.75)
//                                    self.lstartPoint = UnitPoint(x: 0, y: 1)
                                }
                            }.blendMode(.normal)
                    }
                }
            } else if version.hasPrefix("13") {
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
