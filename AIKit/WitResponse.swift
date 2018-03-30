//
//  WitResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

struct WitResponse : Decodable {
    
    let entities: [String: [Entity]]
    
    struct Entity : Decodable {
        let confidence: Double
        let value: String
    }
    
    var intent: String? {
        return entities["intent"]?.first?.value
    }
    
    func firstValueFor(_ key: String) -> String? {
        return entities[key]?.first?.value
    }
    
//    struct Entities : Decodable {
//
//        let intent: [Entity]?
//        let screen: [Entity]?
//    }
    
}
