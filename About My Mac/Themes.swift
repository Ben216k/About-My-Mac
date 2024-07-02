//
//  Themes.swift
//  About My Mac
//
//  Created by Ben Sova on 2/14/24.
//

import SwiftUI

struct AMMTheme {
    let themeId: String
    let image: String
    let graident: Gradient
    let circleColor: Color?
    
    struct Gradient {
        let endPoint = UnitPoint(x: 1.5, y: 1)
        let startPoint = UnitPoint(x: 0.5, y: 1.75)
    }
}

//let allThemes: [AMMTheme] = [
//    .init(themeId: <#T##String#>, image: <#T##String#>, graident: <#T##AMMTheme.Gradient#>, circleColor: <#T##Color?#>)
//]
