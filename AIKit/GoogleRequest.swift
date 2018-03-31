//
//  GoogleRequest.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

struct GoogleRequest : Encodable {
    let input: Input
    let audioConfig = AudioConfig()
    let voice = Voice()
    struct Input : Encodable {
        let text: String
    }
    struct AudioConfig : Encodable {
        let audioEncoding = "mp3"
        let volumeGainDb = 6
        let speakingRate = 1.0
    }
    struct Voice : Encodable {
        let languageCode = "en"
        let name = "en-US-Wavenet-D"
    }
}
