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
    
    var body: some View {
        ZStack {
            switch page {
            case .main:
                ContentView(style: $style, page: $page)
                    .transition(.moveAway)
            case .storage:
                StorageView()
                    .transition(.moveAway)
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
                        Text("Overview")
                            .foregroundColor(.primary)
                            .padding(7.5)
                            .padding(.horizontal, 4)
//                            .background(Color(white: 0.175).cornerRadius(7))
//                            .shadow(color: Color.black.opacity(0.2), radius: 3)
                        Text("Displays")
                            .foregroundColor(.primary)
                            .padding(7.5)
                            .padding(.horizontal, 4)
                        Text("Storage")
                            .foregroundColor(.primary)
                            .padding(7.5)
                            .padding(.horizontal, 4)
                            
                        Text("Support")
                            .foregroundColor(.primary)
                            .padding(7.5)
                            .padding(.horizontal, 4)
                        Text("Resources")
                            .foregroundColor(.primary)
                            .padding(7.5)
                            .padding(.horizontal, 4)
                            .background(Color(white: colorScheme == .light ? 1 : 0.175).cornerRadius(7))
                            .shadow(color: Color.black.opacity(0.15), radius: 3)
                    }.padding(4)
                        .padding(8)
                }.foregroundColor(.primary)
                    .fixedSize().padding(15)
                    .offset(y: page == .main ? 75 : 0)
            }
        }
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
