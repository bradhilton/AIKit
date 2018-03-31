//
//  AIViewControllerDelegate.swift
//  AIKit
//
//  Created by Bradley Hilton on 3/31/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

public protocol AIViewControllerDelegate: class {
    func didDismiss()
    func aiResponse(for witResponse: WitResponse) -> AIResponse
}
