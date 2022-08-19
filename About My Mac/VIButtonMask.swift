import VeliaUI

public struct VIButtonBlend<V: View>: View {
    let view: () -> V
    let id: String
    @Binding var hovered: String?
    let onClick: () -> ()
    @Environment(\.colorScheme) var colorScheme
    var useTextPadding: Bool
    var color: Color
    let useAccent: Bool
    
    public var body: some View {
        Button {
            onClick()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.init(r: 220, g: 220, b: 220))
                    .blendMode(.multiply)
                    .opacity(hovered == id ? 1 : 0.1)
                    .cornerRadius(15)
                ZStack(alignment: .center) {
                    HStack {
                        view()
                    }.foregroundColor(.white)
                    .opacity(hovered == id ? 1 : 0)
                    HStack {
                        view()
                    }.foregroundColor(color)
                    .opacity(hovered == id ? 0 : 1)
                }.padding(7)
                .padding(.horizontal, useTextPadding ? 7 : 0)
            }.fixedSize()
        }.buttonStyle(BorderlessButtonStyle())
        .onHover { hovering in
            withAnimation {
                hovered = hovering ? id : nil
            }
        }
    }
}

// MARK: Initialization

extension VIButtonBlend {
    public init(id: String, h: Binding<String?>, @ViewBuilder view: @escaping () -> V, onClick: @escaping () -> () = {}) {
        self.view = view
        self.id = id
        _hovered = h
        self.onClick = onClick
        useTextPadding = false
        color = Color("Accent")
        useAccent = false
    }
}

extension VIButtonBlend {
    public func inPad() -> Self {
        .init(view: view, id: id, hovered: $hovered, onClick: onClick, useTextPadding: true, color: color, useAccent: useAccent)
    }
    
    public func btColor(_ c: Color) -> Self {
        .init(view: view, id: id, hovered: $hovered, onClick: onClick, useTextPadding: useTextPadding, color: c, useAccent: useAccent)
    }
    
    public func useHoverAccent() -> Self {
        .init(view: view, id: id, hovered: $hovered, onClick: onClick, useTextPadding: useTextPadding, color: color, useAccent: true)
    }
}
