//
//  AIResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

public enum AIResponse {
    case text(String)
    case navigate(Screen)
    case show(Screen)
    case help
    case failure
    
    init(witResponse: WitResponse) {
        guard let intent = witResponse.intent else {
            self = .failure
            return
        }
        switch intent {
        case "navigate":
            guard let screen = witResponse.firstValueFor("screen").flatMap(Screen.init) else {
                self = .failure
                return
            }
            self = .navigate(screen)
//        case "show" where let screen = witResponse.firstValueFor("screen").flatMap({ Screen(rawValue: $0.value) }):
//            self = .show(screen)
        case "help":
            self = .help
        default:
            self = .failure
        }
        if intent == "navigate",
            let screen = witResponse.entities["screen"]?.first.flatMap({ Screen(rawValue: $0.value) }) {
            self = .show(screen)
        }
        else if intent == "show",
            let screen = witResponse.entities["screen"]?.first.flatMap({ Screen(rawValue: $0.value) }) {
            self = .show(screen)
        }
        else if intent == "help" {
            self = .help
        } else { self = .failure }
        
    }
}

public enum Screen : String {
    case friendRequests
    case posts
}
