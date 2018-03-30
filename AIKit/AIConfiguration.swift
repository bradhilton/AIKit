//
//  AIConfiguration.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

public class AIConfiguration {
 
    public init () {}
    
    public func awaitForResponse(for text: String, with completion: (AIResponse) -> ()){
        completion(.text("Hello_Lorraine"))
        
    }
    
    
    
    
    
}
