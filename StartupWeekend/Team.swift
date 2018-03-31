//
//  Team.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation
import XTable

func section(with team: Team) -> Section {
    return Section { section in
        section.rows = [
           row(with: team)
        ]
    }
}

func teamsSection() -> Section {
    return Section { section in
        section.rows = Team.all.map { row(with: $0)}
    }
}

func row(with team: Team) -> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { (cell: TeamTableViewCell) in
            cell.configure(with: team)
        }
    }
}

enum Team {
    case aiKit
    case curbAppeal
    case givv
    case mayday
    case pplCloud
    
    static var all: [Team] = [.aiKit, .curbAppeal, .givv, .mayday, .pplCloud]
    
    var name: String {
        switch self {
        case .aiKit:
            return "AIKit"
        case .curbAppeal:
            return "Curb Appeal"
        case .givv:
            return "Givv"
        case .mayday:
            return "Mayday"
        case .pplCloud:
            return "PPL Cloud"
        }
    }
    
    var cellDescription: String {
        switch self {
        case .aiKit:
            return "A drop-in virtual assistant for websites and apps."
        case .curbAppeal:
            return "Curb Appeal"
        case .givv:
            return "The Go Fund Me for charitable payroll deductions in the workplace"
        case .mayday:
            return "An Anti Bullying App"
        case .pplCloud:
            return "A personal server"
        }
    }
    
    var aiDescription: String {
        switch self {
        case .aiKit:
            return "a drop-in virtual assistant for websites and apps."
        case .curbAppeal:
            return "a real estate app."
        case .givv:
            return "the Go Fund Me for charitable payroll deductions in the workplace"
        case .mayday:
            return "an Anti Bullying App"
        case .pplCloud:
            return "a personal server"
        }
    }
}
