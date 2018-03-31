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
            self = AIResponse(message: "Ask me to show you or tell you about anything in startupWeekend")
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
                self = AIResponse(message: "Here are the teams!", sections: [])
            case "judges":
                //Displays the list of all judge objects
                self = AIResponse(message: "Here are the Judges!", sections: [])
            case "startupWeekend":
                self = AIResponse(message: "")
            case "app":
                self = AIResponse(message: "")
            case "eventDate":
                self = AIResponse(message: "")
            case "eventLocation":
                self = AIResponse(message: "")
            case "team_AIKit":
                self = AIResponse(message: "")
            case "team_PPLCloud":
                self = AIResponse(message: "")
            case "team_CurbAppeal":
                self = AIResponse(message: "")
            case "team_Mayday":
                self = AIResponse(message: "")
            case "team_Givv":
                self = AIResponse(message: "")
            case "amy":
                self = AIResponse(message: "")
            case "john":
                self = AIResponse(message: "")
            case "seth":
                self = AIResponse(message: "")
            case "quinn":
                self = AIResponse(message: "")
            case "peter":
                self = AIResponse(message: "")
            default:
                self = AIResponse(message: "I can't find\(object)")
            }
        case "tell":
            guard let object = witResponse.firstValueFor("object") else {
                self = AIResponse(message: "What do you want me to tell you about?", needsFollowUp: true)
                return
            }
            switch object {
            case "teams":
                //Audibly says names of teams
                self = AIResponse(message: "Here are the teams!", sections: [])
            case "judges":
                //Audibly says names of judges
                self = AIResponse(message: "Here are the Judges!", sections: [])
            case "startupWeekend":
                self = AIResponse(message: "")
            case "app":
                self = AIResponse(message: "")
            case "eventDate":
                self = AIResponse(message: "")
            case "eventLocation":
                self = AIResponse(message: "")
            case "team_AIKit":
                self = AIResponse(message: "")
            case "team_PPLCloud":
                self = AIResponse(message: "")
            case "team_CurbAppeal":
                self = AIResponse(message: "")
            case "team_Mayday":
                self = AIResponse(message: "")
            case "team_Givv":
                self = AIResponse(message: "")
            case "amy":
                self = AIResponse(message: "")
            case "john":
                self = AIResponse(message: "")
            case "seth":
                self = AIResponse(message: "")
            case "quinn":
                self = AIResponse(message: "")
            case "peter":
                self = AIResponse(message: "")
            default:
                self = AIResponse(message: "I can't find\(object)")
            }
        default:
            self = .failure
        }
    }
    
}
