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
        case "tellJoke":
            self = AIResponse(message: "Two men walked into a bar.")
        case "sendMessage":
            guard let recipient = witResponse.firstValueFor("recipient") else {
                self = AIResponse(message: "Who would you like to send it to?", needsFollowUp: true)
                return
            }
            self = AIResponse(message: "Okay, I'll send a message to \(recipient).")
        case "goto":
            guard let appPage = witResponse.firstValueFor("appPage") else {
                self = AIResponse(message: "Where do you want to go?", needsFollowUp: true)
                return
            }
            switch appPage {
            case "teams":
                self = AIResponse(message: "Going to Teams.")
            case "judges":
                self = AIResponse(message: "Going to Judges.")
            case "about":
                self = AIResponse(message: "Let's go!.")
            default:
                self = AIResponse(message: "I can't find\(appPage)")
            }
        default:
            self = .failure
        }
    }
    
}
