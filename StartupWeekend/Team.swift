//
//  Team.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

//struct Team {
//    
//    var name: String
//    var description: String
//}

enum Team {
    case aiKit
    case curbAppeal
    case givv
    case mayday
    
    var name: String {
        switch self {
        case .aiKit:
            return "AIKit"
        case .curbAppeal:
            return "Curb Appeal"
        case .givv:
            return "Givv"
        case .mayday:
            return "Mayday - Anti Bullying App"
        }
    }
    
    var description: String {
        switch self {
        case .aiKit:
            return "A drop-in virtual assistant for websites and apps."
        case .curbAppeal:
            return "Curb Appeal"
        case .givv:
            return "The Go Fund Me for charitable payroll deductions in the workplace"
        case .mayday:
            return "An Anti Bullying App"
        }
    }
}
