//
//  AVAudioPCMBuffer.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation
import AVKit
import Accelerate

extension AVAudioPCMBuffer {
    
    var power: Float? {
        guard let data = floatChannelData?[0] else {
            return nil
        }
        let count = stride * Int(frameLength)
        var dbData = [Float](repeating: 0.0, count: count)
        var one: Float = 0.0
        vDSP_vdbcon(data, 1, &one, &dbData, 1, vDSP_Length(count), 1)
        var avgLevel: Float = 0.0
        vDSP_rmsqv(dbData, 1, &avgLevel, vDSP_Length(frameLength))
        return avgLevel
    }
    
}
