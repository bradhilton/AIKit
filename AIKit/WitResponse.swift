//
//  WitResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

struct WitResponse {
    
    struct Entities {
        let intent: [Intent]?
        
        struct Intent {
            let confidence: Double
            let value: String
        }
        
    }
    
}
