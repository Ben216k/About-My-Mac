//
//  Preferences.swift
//  About My Mac
//
//  Created by Ben Sova on 6/10/22.
//

import VeliaUI

struct PreferencesView : View {
    
    @State var hovered: String?
    @Binding var selectedStyle: AMStyles
    @State var triedToFindSequoia = false
    @Binding var backgroundBlur: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VIHeader(p: "About My Mac", s: "v\(AppInfo.version) (\(AppInfo.build))")
                        .alignment(.leading)
                    Spacer()
                    VIButton(id: "GITHUB", h: $hovered) {
                        Image("GitHubMark")
                    } onClick: {
                        NSWorkspace.shared.open("https://github.com/Ben216k/About-My-Mac")
                    }
                }.padding(.bottom, 5)
                
                Text("Style")
                    .font(.headline.weight(.semibold))
                    .onAppear {
                        triedToFindSequoia = UserDefaults.standard.bool(forKey: "TriedToFindSequoia")
                    }
                HStack(spacing: 0) {
                    
                    // MARK: Big Sur Styles
                    
                    if sysVersion.hasPrefix("11") {
                        
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .bigSur1, gradient: [.init(r: 0, g: 220, b: 239), .init(r: 5, g: 229, b: 136)])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .mario, gradient: [.init("Mario1"), .init("Mario2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .lime, gradient: [.init("BSLime1"), .init("BSLime2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .water, gradient: [.init("BSWater1"), .init("BSWater2")])
                    } else if sysVersion.hasPrefix("12") {
                        
                        // MARK: Monterey Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .monterey1, gradient: [.init(r: 193, g: 0, b: 214), .init(r: 74, g: 0, b: 235)])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .monterey2, gradient: [.init("MontereyA1"), .init("MontereyA2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .pink, gradient: [.init("P1NK"), .init("P2NK")])
                        
                    } else if sysVersion.hasPrefix("13") {
                        
                        // MARK: Ventura Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .venLight, gradient: [.init("13LA"), .init("13LB")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .venDark, gradient: [.init("13DA"), .init("13DB")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .venBlue, gradient: [.init("13D1"), .init("13D2")])
                        
                    } else if sysVersion.hasPrefix("14") {
                        
                        // MARK: Sonoma Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .sonLight, gradient: [.init("14L1"), .init("14L2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .sonDark, gradient: [.init("14D1"), .init("14D2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .sonPink, gradient: [.init("14P1"), .init("14P2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .sonBlue, gradient: [.init("14B1"), .init("14B2")])
                        
                    } else {
                        
                        // MARK: Sequoia Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .seqLight, gradient: [.init("15L1"), .init("15L2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .seqDark, gradient: [.init("15D1"), .init("15D2")])
                        
                        if triedToFindSequoia {
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .sat, gradient: [.white, .black])
                        }
                        
                    
                        
                    }

                }.padding(.top, -5)
                .padding(.leading, -4)
                
                Toggle("Blurred Background", isOn: $backgroundBlur)
                    .onChange(of: backgroundBlur) { _ in
                        UserDefaults.standard.set(backgroundBlur, forKey: "BlurBG")
                    }
                
                
                Rectangle().frame(height: 0)
                
                Text("Acknowledgements")
                    .font(.headline.weight(.semibold))
                    .padding(.bottom, 1)
                
                if #available(macOS 13, *) {
                    Text("- [JohnSundell's ShellOut Library](github.com/JohnSundell/ShellOut)\n- The beta testers and feature suggesters on the [Ursinia Projects discord](discord.gg/2DxVn4HDX6). \n - 0xCUBE's and MDNich's contributions from their project, [About This Hack](github.com/0xCUB3/About-This-Hack).")
                } else {
                    Text("- JohnSundell's ShellOut Library (github.com/JohnSundell/ShellOut)\n- The beta testers and feature suggesters on the Ursinia Projects discord. (discord.gg/2DxVn4HDX6)\n - 0xCUBE's and MDNich's contributions from their project (github.com/0xCUB3/About-This-Hack)")
                }
                
            }.padding(30)
        }
    }
    
}

struct SelectStyleButton : View {
    
    @Binding var selectedStyle: AMStyles
    let style: AMStyles
    let gradient: [Color]
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                selectedStyle = style
                UserDefaults.standard.setValue(selectedStyle.rawValue, forKey: "Style")
            }
        } label: {
            ZStack {
                LinearGradient(gradient: .init(colors: gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 75, height: 50)
                    .cornerRadius(10)
                if selectedStyle == style {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Accent"), lineWidth: 6)
                        .frame(width: 75, height: 50)
                        .foregroundColor(.clear)
                }
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(NSColor.windowBackgroundColor), lineWidth: 3)
                    .frame(width: 73, height: 48)
                    .foregroundColor(.clear)
            }
                .padding(5)
        }.buttonStyle(.borderless)
    }
    
}

final class AppInfo {
    static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let build = Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)!
}

extension URL: ExpressibleByStringInterpolation {
    
    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }
    
}

enum AMStyles: String {
    case bigSur1 = "BigSur1"
    case mario = "Mario"
    case lime = "Lime"
    case water = "Water"
    case monterey1 = "Monterey1"
    case monterey2 = "Monterey2"
    case pink = "PINK"
    case venLight = "VenturaL"
    case venDark = "VenturaD"
    case venBlue = "VenturaB"
    case sonLight = "SonomaL"
    case sonDark = "SonomaD"
    case sonPink = "SonomaPink"
    case sonBlue = "SonomaBlue"
    case seqLight = "SequoiaLight"
    case seqDark = "SequoiaDark"
    case sat = "SequoiaAdventureTeam"
}
