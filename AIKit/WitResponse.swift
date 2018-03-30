//
//  WitResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

struct WitResponse : Decodable {
    
    let entities: Entities
    
    struct Entities : Decodable {
        
        let intent: [Intent]?
        
        struct Intent : Decodable {
            let confidence: Double
            let value: String
        }
        
    }
    
}
