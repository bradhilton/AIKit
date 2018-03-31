//
//  Judge.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import XTable

func section(with judge: Judge) -> Section {
    return Section { section in
        section.rows = [
            row(with: judge)
        ]
    }
}

func judgesSection() -> Section {
    return Section { section in
        section.rows = Judge.all.map { row(with: $0)}
    }
}

func row(with judge: Judge) -> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { (cell: JudgeTableViewCell) in
            cell.configure(with: judge)
        }
    }
}

enum Judge {
    case john
    case seth
    case amy
    case peter
    case quinn
    
    static var all: [Judge] = [.amy, .john, .peter, .quinn, .seth]
    
    var name: String {
        switch self {
        case .amy:
            return "Amy Caldwell"
        case .john:
            return "John Richards"
        case .peter:
            return "Peter Jay"
        case .quinn:
            return "Quinn Peterson"
        case .seth:
            return "Seth Taylor"
        }
    }
    
    var image: UIImage {
        switch self {
        case .amy:
            return #imageLiteral(resourceName: "amy_caldwell")
        case .john:
            return #imageLiteral(resourceName: "john_richards")
        case .peter:
            return #imageLiteral(resourceName: "peter_jay")
        case .quinn:
            return #imageLiteral(resourceName: "quinn_peterson")
        case .seth:
            return #imageLiteral(resourceName: "seth_taylor")
        }
    }
    
    var title: String {
        switch self {
        case .john:
            return "Entrepreneur | Investor | Mentor | Professor | Executive"
        case .seth:
            return "Creative Director/Founder"
        case .amy:
            return "Executive Director/Co-Founder"
        case .peter:
            return "Attorney/MBA/Entrepreneur - Technical Leader for Utah Ignite, Owner of Coconut Cove and Vault Estate Planning"
        case .quinn:
            return "Executive Director at Downtown Provo Inc."
        }
    }
    
    var aiDescription: String {
        switch self {
        case .amy:
            return "is the Executive Director and a co-founder at the newest business accelerator in Provo, Ut RevRoad."
        case .john:
            return "is a co-founder of several ventures leading to high-multiple exits, an active angel investor, startup mentor to thousands of entrepreneurs, a professor and executive."
        case .peter:
            return "is a JD / MBA with a well rounded business background in business consulting, in International Business, Real Estate, and Litigation."
        case .quinn:
            return "manages the value of the Downtown Provo area. He assists in networking and addressing needs of the business community and the visitors experience downtown."
        case .seth:
            return "is the founder of Stotion. He demonstrates expertise in all things design, and a robust comprehension of business strategy, technology, web development, and behavioral psychology."
        }
    }
    
    var bio: String {
        switch self {
        case .john:
            return "Entrepreneur: Co-founder of several ventures leading to high-multiple exits.\nInvestor: Active angel investor having directly invested in scores of new and mature ventures as well as hundreds more through investment funds.\nMentor: Give much time to mentor startup entrepreneurs, having mentored thousands.\nProfessor: Teach entrepreneurship (lean startup) at leading universities.\nExecutive: C-level executive with substantial early-stage experience. High premium on Internet, software, and lean startup. Focus has been on advertising and business services. Technically adept. Programmed business solutions before turning full-time attention to management."
        case .amy:
            return "Amy is the Executive Director and a co-founder at the newest business accelerator in Provo, Ut RevRoad.  Amy is over new businesses, and relationships both within RevRoad and the community.    She supported the Responsibility Foundation as an executive assistant and office manager. Amy has managed a high-end consignment shop and been a store coordinator and customer service manager for a large corporation in electronic retail sales. She enjoyed her time as an inside sales manager and outside sales for a cellular company, organizing large fundraising events and building strong customer networks. She worked for Caroline Productions as an assistant locations manager and worked with directors and producers to film the hit show “Touched by an Angel.”"
        case .peter:
            return "JD / MBA with a well rounded business background in business consulting (run a business and new product accelerator that over 220 companies applied for in 2014), in International Business (Corporate Counsel, Regulatory Compliance, and Financial Management), Real Estate (Commercial Leasing, Title Insurance, and Escrow), and Litigation (Antitrust, Consumer Protection, Securities, Family Law, Probate). As corporate counsel, managed contract negotiations and drafting, domestic and international corporate compliance, intellectual property, and litigation. Created complex financial business models for commercial contracts."
        case .quinn:
            return "We manage the value of the Downtown Provo area. We assist in networking and addressing needs of the business community and the visitors experience downtown. We don't run any big events ourselves but we help facilitate events and success of all the great programs that are already here."
        case .seth:
            return "As the founder of Stotion, Seth has championed a powerful approach to design thinking and strategy. He demonstrates expertise in all things design, and a robust comprehension of business strategy, technology, web development, and behavioral psychology.\nHis personal philosophy is that any project, big or small, can be made great. His unique approach has proven valuable to billion dollar companies such as Google, Samsung and AmericanExpress. Seth’s work has garnered awards from AIGA and his custom fonts and imagery have been licensed by A&E Television Networks, Major League Baseball, MSP-C, and others. Seth is the creator of fontlines.com. For fun, he likes to collect entomological treasures, sleep outdoors, play and mentor his kids, learn about biomimicry, and mountain bike."
        }
    }
}
