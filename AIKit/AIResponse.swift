//
//  AIResponse.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import XTable

public struct AIResponse {
    public let message: String
    public let sections: [Section]
    public init(message: String, sections: [Section] = []) {
        self.message = message
        self.sections = sections
    }
    public static let failure = AIResponse(message: "I don't know how to answer that.")
}

extension AIResponse {
    
    init?(with response: WitResponse) {
        return nil
    }
    
}
