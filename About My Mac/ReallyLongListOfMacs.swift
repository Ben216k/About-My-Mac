//
//  ReallyLongListOfMacs.swift
//  About My Mac
//
//  Created by Ben Sova on 8/19/22.
//

import Foundation

// Thanks for AstroKid

func getMacName(infoString: String) -> String {
        // from https://everymac.com/systems/by_capability/mac-specs-by-machine-model-machine-id.html
//        let infoString = (try? call("sysctl hw.model | cut -f2 -d \" \" | tr -d '\n'")) ?? "LOL"
        switch(infoString) {
        case "iMac4,1":
            
            return "iMac 17-Inch \"Core Duo\" 1.83"
        case "iMac4,2":
            
            return "iMac 17-Inch \"Core Duo\" 1.83 (IG)"
        case "iMac5,2":
            
            return "iMac 17-Inch \"Core 2 Duo\" 1.83 (IG)"
        case "iMac5,1":
            
            return "iMac 17-Inch \"Core 2 Duo\" 2.0"
        case "iMac7,1":
            
            return "iMac 20-Inch \"Core 2 Duo\" 2.0 (Al)"
        case "iMac8,1":
            
            return "iMac (Early 2008)"
        case "iMac9,1":
            
            return "iMac (Mid 2009)"
        case "iMac10,1":
            
            return "iMac (Late 2009)"
        case "iMac11,2":
            
            return "iMac 21.5-Inch (Mid 2010)"
        case "iMac12,1":
            
            return "iMac 21.5-Inch (Mid 2011)"
        case "iMac13,1":
            
            return "iMac 21.5-Inch (Mid 2012/Early 2013)"
        case "iMac14,1","iMac14,3":
            
            return "iMac 21.5-Inch (Late 2013)"
        case "iMac14,4":
            
            return "iMac 21.5-Inch (Mid 2014)"
        case "iMac16,1","iMac16,2":
            
            return "iMac 21.5-Inch (Late 2015)"
        case "iMac18,1":
            
            return "iMac 21.5-Inch (2017)"
        case "iMac18,2":
            
            return "iMac 21.5-Inch (Retina 4K, 2017)"
        case "iMac19,3":
            
            return "iMac 21.5-Inch (Retina 4K, 2019)"
        case "iMac11,1":
            
            return "iMac 27-Inch (Late 2009)"
        case "iMac11,3":
            
            return "iMac 27-Inch (Mid 2010)"
        case "iMac12,2":
            
            return "iMac 27-inch (Mid 2011)"
        case "iMac13,2":
            
            return "iMac 27-inch (Mid 2012)"
        case "iMac14,2":
            
            return "iMac 27-inch (Late 2013)"
        case "iMac15,1":
            
            return "iMac 27-inch (Retina 5K, Late 2014)"
        case "iMac17,1":
            
            return "iMac 27-inch (Retina 5K, Late 2015)"
        case "iMac18,3":
            
            return "iMac 27-inch (Retina 5K, 2017)"
        case "iMac19,1":
            
            return "iMac 27-inch (Retina 5K, 2019)"
        case "iMac19,2":
            
            return "iMac 21.5-inch (Retina 4K, 2019)"
        case "iMac20,1","iMac20,2":
            
            return "iMac 27-inch (Retina 5K, 2020)"
        case "iMac21,1","iMac21,2":
            
            return "iMac (24-inch, M1, 2021)"
            
        
        case "iMacPro1,1":
            
            return "iMac Pro (2017)"
        
        case "Macmini3,1":
            
            return "Mac Mini (Late 2009)"
        case "Macmini4,1":
            
            return "Mac Mini (Mid 2010)"
        case "Macmini5,1":
            
            return "Mac Mini (Mid 2011)"
        case "Macmini5,2","Macmini5,3":
            return "Mac Mini (Mid 2011)"
        case "Macmini6,1":
            
            return "Mac Mini (Late 2012)"
        case "Macmini6,2":
            
            return "Mac Mini Server (Late 2012)"
        case "Macmini7,1":
            
            return "Mac Mini (Late 2014)"
        case "Macmini8,1":
            
            return "Mac Mini (Late 2018)"
        case "Macmini9,1":
            
            return "Mac Mini (M1, 2020)"
            
        case "MacPro3,1":
            
            return "Mac Pro (2008)"
        case "MacPro4,1":
            
            return "Mac Pro (2009)"
        case "MacPro5,1":
            
            return "Mac Pro (2010-2012)"
        case "MacPro6,1":
            
            return "Mac Pro (Late 2013)"
        case "MacPro7,1":
            
            return "Mac Pro (2019)"
            
        case "MacBook5,1":
            
            return "MacBook (Original, Unibody)"
        case "MacBook5,2":
            
            return "MacBook (2009)"
        case "MacBook6,1":
            
            return "MacBook (Late 2009)"
        case "MacBook7,1":
            
            return "MacBook (Mid 2010)"
        case "MacBook8,1":
            
            return "MacBook (Early 2015)"
        case "MacBook9,1":
            
            return "MacBook (Early 2016)"
        case "MacBook10,1":
            
            return "MacBook (Mid 2017)"
        case "MacBookAir1,1":
            
            return "MacBook Air (2008, Original)"
        case "MacBookAir2,1":
            
            return "MacBook Air (Mid 2009, NVIDIA)"
        case "MacBookAir3,1":
            
            return "MacBook Air (11-inch, Late 2010)"
        case "MacBookAir3,2":
            
            return "MacBook Air (13-inch, Late 2010)"
        case "MacBookAir4,1":
            
            return "MacBook Air (11-inch, Mid 2011)"
        case "MacBookAir4,2":
            
            return "MacBook Air (13-inch, Mid 2011)"
        case "MacBookAir5,1":
            
            return "MacBook Air (11-inch, Mid 2012)"
        case "MacBookAir5,2":
            
            return "MacBook Air (13-inch, Mid 2012)"
        case "MacBookAir6,1":
            
            return "MacBook Air (11-inch, Mid 2013/Early 2014)"
        case "MacBookAir6,2":
            
            return "MacBook Air (13-inch, Mid 2013/Early 2014)"
        case "MacBookAir7,1":
            
            return "MacBook Air (11-inch, Early 2015/2017)"
        case "MacBookAir7,2":
            
            return "MacBook Air (13-inch, Early 2015/2017)"
        case "MacBookAir8,1":
            
            return "MacBook Air (13-inch, Late 2018)"
        case "MacBookAir8,2":
            
            return "MacBook Air (13-inch, True-Tone, 2019)"
        case "MacBookAir9,1":
            
            return "MacBook Air (13-inch, 2020)"
        case "MacBookAir10,1":
            
            return "MacBook Air (13-inch, M1, 2020)"
            
        case "MacBookPro5,5":
            
            return "MacBook Pro (13-inch, 2009)"
        case "MacBookPro7,1":
            
            return "MacBook Pro (13-inch, Mid 2010)"
        case "MacBookPro8,1":
            
            return "MacBook Pro (13-inch, Early 2011)"
        case "MacBookPro9,2":
            
            return "MacBook Pro (13-inch, Mid 2012)"
        case "MacBookPro10,2":
            
            return "MacBook Pro (Retina, 13-inch, 2012)"
        case "MacBookPro11,1":
            
            return "MacBook Pro (Retina, 13-inch, Late 2013/Mid 2014)"
        case "MacBookPro12,1":
            
            return "MacBook Pro (Retina, 13-inch, 2015)"
        case "MacBookPro13,1":
            
            return "MacBook Pro (Retina, 13-inch, Late 2016)"
        case "MacBookPro13,2":
            
            return "MacBook Pro (Retina, 13-inch, Touch Bar, Late 2016)"
        case "MacBookPro14,1":
            
            return "MacBook Pro (Retina, 13-inch, Mid 2017)"
        case "MacBookPro14,2":
            
            return "MacBook Pro (Retina, 13-inch, Touch Bar, Mid 2017)"
        case "MacBookPro15,2":
            
            return "MacBook Pro (Retina, 13-inch, Touch Bar, Mid 2018)"
        case "MacBookPro15,4":
            
            return "MacBook Pro (Retina, 13-inch, Touch Bar, Mid 2019)"
        case "MacBookPro16,2","MacBookPro16,3":
            
            return "MacBook Pro (Retina, 13-inch, Touch Bar, Mid 2020)"
        case "MacBookPro16,4":
            
            return "MacBook Pro (Retina, 16-inch, Touch Bar, Mid 2019)"
        case "MacBookPro17,1":
            
            return "MacBook Pro (13-inch, M1, 2020)"
            
        case "MacBookPro6,2":
            
            return "MacBook Pro (15-inch, Mid 2010)"
        case "MacBookPro8,2":
            
            return "MacBook Pro (15-inch, Early 2011)"
        case "MacBookPro9,1":
            
            return "MacBook Pro (15-inch, Mid 2012)"
        case "MacBookPro10,1":
            
            return "MacBook Pro (Retina, 15-inch, Mid 2012)"
        case "MacBookPro11,2":
            
            return "MacBook Pro (Retina, 15-inch, Late 2013)"
        case "MacBookPro11,3":
            
            return "MacBook Pro (Retina, 15-inch, Mid 2014)"
        case "MacBookPro11,4","MacBookPro11,5":
            
            return "MacBook Pro (Retina, 15-inch, Mid 2015)"
        case "MacBookPro13,3":
            
            return "MacBook Pro (Retina, 15-inch, Touch Bar, Late 2016)"
        case "MacBookPro14,3":
            
            return "MacBook Pro (Retina, 15-inch, Touch Bar, Late 2017)"
        case "MacBookPro15,1":
            
            return "MacBook Pro (Retina, 15-inch, Touch Bar, 2018/2019)"
        case "MacBookPro15,3":
            
            return "MacBook Pro (Retina, 15-inch, Touch Bar, 2018/2019)"
        case "MacBookPro16,1":
            
            return "MacBook Pro (Retina, 16-inch, Touch Bar, 2019)"
        case "MacBookPro8,3":
            
            return "MacBook Pro (17-inch, Late 2011)"
            
        case "Mac14,2":
            return "MacBook Air (13-inch, M2, 2022)"
            
        case "Mac14,7":
            return "MacBook Pro (13-inch, M2, 2022)"
            
        case "MacBookPro18,1", "MacBookPro18,2":
            return "MacBook Pro (14-inch, 2021)"
            
        case "MacBookPro18,3", "MacBookPro18,4":
            return "MacBook Pro (16-inch, 2021)"
            
        default:
            return "Mac"
        }
    }
