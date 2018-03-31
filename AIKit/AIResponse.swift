//
//  AIResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import XTable

let jokes = [
    "If I got 50 cents for every failed math exam, I’d have $ 6.30 now.",
    "The first computer dates back to Adam and Eve. It was an Apple with limited memory, just one byte. And then everything crashed.",
]

public struct AIResponse {
    public let message: String
    public let needsFollowUp: Bool
    public let sections: [Section]
    public init(message: String, needsFollowUp: Bool = false, sections: [Section] = []) {
        self.message = message
        self.needsFollowUp = needsFollowUp
        self.sections = sections
    }
    public static let failure = AIResponse(message: "I don't know how to answer that.")
}

extension AIResponse {
    
    init?(with response: WitResponse, and configuration: AIConfiguration) {
        guard let intent = response.intent else {
            return nil
        }
        let appName = configuration.appName ?? "this app"
        switch intent {
        case "howSmartAreYou":
            self = AIResponse(message: "I know enough to help you with \(appName).")
        case "tellJoke":
            self = AIResponse(message: "\(jokes[Int(arc4random_uniform(UInt32(jokes.count)))])")
        case "whoAmI":
            self = AIResponse(message: "The User.")
        case "howAreYouDoing":
            self = AIResponse(message: "I'm doing fine, How are you?")
        case "whoAreYou":
            self = AIResponse(message: "I am your virtual assistant for \(appName).")
        case "whatsUp":
            self = AIResponse(message: "The sky")
        case "sayGoodbye":
            self = AIResponse(message: "Goodbye.")
        case "sayHello":
            self = AIResponse(message: "Hello.")
//        case "howDoIUseYou":
//            self = AIResponse(message: "Ask me questions about \(appName) or give me commands")
        default:
            return nil
        }
    }
    
}
