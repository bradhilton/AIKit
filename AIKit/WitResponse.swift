//
//  WitResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

public struct WitResponse : Decodable {
    
    public let entities: [String: [Entity]]
    
    public struct Entity : Decodable {
        public let confidence: Double
        public let value: String
    }
    
    public var intent: String? {
        return entities["intent"]?.first?.value
    }
    
    public func firstValueFor(_ key: String) -> String? {
        return entities[key]?.first?.value
    }
    
}
