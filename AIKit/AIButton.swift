//
//  AIButton.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import Foundation

public func createAIButton(target: Any, action: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("Assistant", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(target, action: action, for: .touchUpInside)
    return button
}

