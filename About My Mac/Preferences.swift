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
                HStack(alignment: .top, spacing: 0) {
                    
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
                        
                    } else if sysVersion.hasPrefix("15") {
                        
                        // MARK: Sequoia Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .seqLight, gradient: [.init("15L1"), .init("15L2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .seqDark, gradient: [.init("15D1"), .init("15D2")])
                        
                        if triedToFindSequoia {
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .sat, gradient: [.white, .black])
                        }
                        
                    
                        
                    } else if sysVersion.hasPrefix("26") {
                        
                        // MARK: Sequoia Styles
                        
                        VStack(spacing: 0) {
                            
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .tahDusk, gradient: [.init("26D1"), .init("26D2")])
                            
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .tahNews, gradient: [.init("26N1"), .init("26N2")])
                            
                        }
                        
                        VStack(spacing: 0) {
                            
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .tahDay, gradient: [.init("26L1"), .init("26L2")])
                            
                            SelectStyleButton(selectedStyle: $selectedStyle, style: .goaGold, gradient: [.init("GOA1"), .init("GOA2")])
                            
                        }
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .tahSeafoam, gradient: [.init("BSLime1"), .init("BSWater1")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .tahWine, gradient: [.init("26W1"), .init("26W2")])
                    
                        
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
                    Text("- [JohnSundell's ShellOut Library](github.com/JohnSundell/ShellOut)\n- The beta testers and feature suggesters on the [216k Labs discord](discord.gg/2DxVn4HDX6). \n - 0xCUBE's and MDNich's contributions from their project, [About This Hack](github.com/0xCUB3/About-This-Hack).")
                } else {
                    Text("- JohnSundell's ShellOut Library (github.com/JohnSundell/ShellOut)\n- The beta testers and feature suggesters on the 216k Labs discord. (discord.gg/2DxVn4HDX6)\n - 0xCUBE's and MDNich's contributions from their project (github.com/0xCUB3/About-This-Hack)")
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
                        .stroke(Color(style.colorR), lineWidth: 6)
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
    case tahDusk = "TahoeDusk"
    case tahDay = "TahoeDay"
    case tahWine = "Wine"
    case tahPINK = "PinkTahoe"
    case tahSeafoam = "Seafoam"
    case tahNews = "TahNews"
    case goaGold = "GoaGold"
    case sat = "SequoiaAdventureTeam"
    
    var color1: String {
        switch self {
        case .tahDay: "26L1"
        case .tahDusk: "26D1"
        case .tahPINK: "P1NK"
        case .tahWine: "26W1"
        case .tahSeafoam: "26S1"
        case .tahNews: "26N1"
        case .goaGold: "GOA1"
        default: "26L1"
        }
    }
    
    var color2: String {
        switch self {
        case .tahDay: "26L2"
        case .tahDusk: "26D2"
        case .tahPINK: "P2NK"
        case .tahWine: "26W2"
        case .tahSeafoam: "26S2"
        case .tahNews: "26N2"
        case .goaGold: "GOA2"
        default: "26L2"
        }
    }
    
    var colorR: String {
        switch self {
        case .tahDay: "26LR"
        case .tahDusk: "26DR"
        case .tahPINK: "MontereyA1"
        case .tahWine: "26WR"
        case .tahSeafoam: "26SR"
        case .tahNews: "26NR"
        case .goaGold: "GOAR"
        default: "26LR"
        }
    }
    
    var image26: String {
        switch self {
        case .tahDay, .tahDusk, .tahWine, .tahSeafoam, .tahNews, .goaGold:
            self.rawValue
        default: Self.tahDay.rawValue
        }
    }
}
