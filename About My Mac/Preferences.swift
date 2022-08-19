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
                        NSWorkspace.shared.open("https://github.com/Ben216k/Patched-Sur")
                    }
                }.padding(.bottom, 5)
                
                Text("Style")
                    .font(.headline.weight(.semibold))
                HStack(spacing: 0) {
                    
                    // MARK: Big Sur Styles
                    
                    if sysVersion.hasPrefix("11") {
                        
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .bigSur1, gradient: [.init(r: 0, g: 220, b: 239), .init(r: 5, g: 229, b: 136)])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .mario, gradient: [.init("Mario1"), .init("Mario2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .lime, gradient: [.init("BSLime1"), .init("BSLime2")])
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .water, gradient: [.init("BSWater1"), .init("BSWater2")])
                    } else {
                        
                        // MARK: Monterey Styles
                        
                        SelectStyleButton(selectedStyle: $selectedStyle, style: .monterey1, gradient: [.init(r: 193, g: 0, b: 214), .init(r: 74, g: 0, b: 235)])
                        
                    }

                }.padding(.top, -5)
                .padding(.leading, -4)
                
                Rectangle().frame(height: 0)
                
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
}
