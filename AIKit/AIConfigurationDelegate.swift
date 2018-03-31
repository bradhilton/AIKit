//
//  AIConfigurationDelegate.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

protocol AIConfigurationDelegate : class {
    func configuration(_ configuration: AIConfiguration, userInputUpdated input: String)
    func configurationStartedLoadingResponse(_ configuration: AIConfiguration)
    func configuration(_ configuration: AIConfiguration, didReceiveResponse response: AIResponse)
    func configuration(_ configuration: AIConfiguration, updatedPowerLevel power: Float)
}

