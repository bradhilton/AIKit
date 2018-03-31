//
//  AIResponse.swift
//  StartupWeekend
//
//  Created by Bradley Hilton on 3/31/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import AIKit

extension AIResponse {
    
    init(for witResponse: WitResponse) {
        guard let intent = witResponse.intent else {
            self = .failure
            return
        }
        switch intent {
        case "HowDoIUseYou":
            self = AIResponse(message: "Ask me to show you or tell you about anything in Startup Weekend", sections: [howToSection()])
        case "sendMessage":
            guard let recipient = witResponse.firstValueFor("recipient") else {
                self = AIResponse(message: "Who would you like to send it to?", needsFollowUp: true)
                return
            }
            self = AIResponse(message: "Okay, I'll send a message to \(recipient).")
//        case "goto":
//            guard let appPage = witResponse.firstValueFor("appPage") else {
//                self = AIResponse(message: "Where do you want to go?", needsFollowUp: true)
//                return
//            }
//            switch appPage {
//            case "teams":
//                self = AIResponse(message: "Going to Teams.")
//            case "judges":
//                self = AIResponse(message: "Going to Judges.")
//            case "about":
//                self = AIResponse(message: "Let's go!.")
//            default:
//                self = AIResponse(message: "I can't find\(appPage)")
//            }
        case "show":
            guard let object = witResponse.firstValueFor("object") else {
                self = AIResponse(message: "What do you want me to show?", needsFollowUp: true)
                return
            }
            switch object {
            case "teams":
                //Displays the list of all team objects
                self = AIResponse(message: "Here are the teams!", sections: [teamsSection()])
            case "judges":
                //Displays the list of all judge objects
                self = AIResponse(message: "Here are the Judges!", sections: [judgesSection()])
            case "startupWeekend":
                self = AIResponse(message: "Here is some info about Startup Weekend", sections: [startupWeekendSection()])
            case "app":
                self = AIResponse(message: "Here is a picture of me:", sections: [logoSection()])
            case "eventDate":
                self = AIResponse(message: "", sections: [datesSection()])
            case "eventLocation":
                self = AIResponse(message: "", sections: [locationSection()])
            case "team_AIKit":
                self = AIResponse(message: "Here is some info about \(Team.aiKit.name)", sections:[section(with: Team.aiKit)])
            case "team_PPLCloud":
                self = AIResponse(message: "Here is some info about \(Team.pplCloud.name)", sections:[section(with: Team.pplCloud)])
            case "team_CurbAppeal":
                self = AIResponse(message: "Here is some info about \(Team.curbAppeal.name)", sections:[section(with: Team.curbAppeal)])
            case "team_Mayday":
                self = AIResponse(message: "Here is some info about \(Team.mayday.name)", sections:[section(with: Team.mayday)])
            case "team_Givv":
                self = AIResponse(message: "Here is some info about \(Team.givv.name)", sections:[section(with: Team.givv)])
            case "amy":
                self = AIResponse(message: "Here is some info about \(Judge.amy.name)", sections:[section(with: Judge.amy)])
            case "john":
                self = AIResponse(message: "Here is some info about \(Judge.john.name)", sections:[section(with: Judge.john)])
            case "seth":
                self = AIResponse(message: "Here is some info about \(Judge.seth.name)", sections:[section(with: Judge.seth)])
            case "quinn":
                self = AIResponse(message: "Here is some info about \(Judge.quinn.name)", sections:[section(with: Judge.quinn)])
            case "peter":
                self = AIResponse(message: "Here is some info about \(Judge.peter.name)", sections:[section(with: Judge.peter)])
            default:
                self = AIResponse(message: "I don't know how to answer that, here are some questions you can ask me:", sections: [howToSection()])
            }
        case "tell":
            guard let object = witResponse.firstValueFor("object") else {
                self = AIResponse(message: "What do you want me to tell you about?", needsFollowUp: true)
                return
            }
            switch object {
            case "teams":
                //Audibly says names of teams
                var teamsString = ""
                for (index, team) in Team.all.enumerated() {
                    if index == Team.all.count - 1 {
                        teamsString.append("and \(team.name)")
                    } else {
                        teamsString.append("\(team.name), ")
                    }
                }
                self = AIResponse(message: "There are \(Team.all.count) teams, they are \(teamsString)", sections: [])
            case "judges":
                //Audibly says names of judges
                var judgesString = ""
                for (index, judge) in Judge.all.enumerated() {
                    if index == Judge.all.count - 1 {
                        judgesString.append("and \(judge.name)")
                    } else {
                        judgesString.append("\(judge.name), ")
                    }
                }
                self = AIResponse(message: "There are \(Judge.all.count) judges, they are \(judgesString)", sections: [])
            case "startupWeekend":
                self = AIResponse(message: StartupWeekend().description)
            case "app":
                self = AIResponse(message: "This is the Startup Weekend app, the best app ever!")
            case "eventDate":
                self = AIResponse(message: StartupWeekend().dates)
            case "eventLocation":
                self = AIResponse(message: StartupWeekend().aiLocation)
            case "team_AIKit":
                self = AIResponse(message: "\(Team.aiKit.name) is \(Team.aiKit.aiDescription)")
            case "team_PPLCloud":
                self = AIResponse(message: "\(Team.pplCloud.name) is \(Team.pplCloud.aiDescription)")
            case "team_CurbAppeal":
                self = AIResponse(message: "\(Team.curbAppeal.name) is \(Team.curbAppeal.aiDescription)")
            case "team_Mayday":
                self = AIResponse(message: "\(Team.mayday.name) is \(Team.mayday.aiDescription)")
            case "team_Givv":
                self = AIResponse(message: "\(Team.givv.name) is \(Team.givv.aiDescription)")
            case "amy":
                self = AIResponse(message: "\(Judge.amy.name) \(Judge.amy.aiDescription)")
            case "john":
                self = AIResponse(message: "\(Judge.john.name) \(Judge.john.aiDescription)")
            case "seth":
                self = AIResponse(message: "\(Judge.seth.name) \(Judge.seth.aiDescription)")
            case "quinn":
                self = AIResponse(message: "\(Judge.quinn.name) \(Judge.quinn.aiDescription)")
            case "peter":
                self = AIResponse(message: "\(Judge.peter.name) \(Judge.peter.aiDescription)")
            default:
                self = AIResponse(message: "I don't know how to answer that, here are some questions you can ask me:", sections: [howToSection()])
            }
        default:
            self = .failure
        }
    }
    
}
