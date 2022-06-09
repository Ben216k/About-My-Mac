//
//  main.swift
//  About My Mac
//
//  Created by Ben Sova on 6/8/22.
//

import Foundation

print("Swift is dumb sometimes")

if #available(macOS 13, *) {
    About_My_MacApp13.main()
} else {
    About_My_MacApp.main()
}
