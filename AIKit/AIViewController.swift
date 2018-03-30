//
//  AIViewController.swift
//  AIKit
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit

class AIViewController: UIViewController {
    
    private var configuration: AIConfiguration!
    
    class func create(with configuration: AIConfiguration) -> AIViewController {
        let storyboard = UIStoryboard(name: "AIKit", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! AIViewController
        viewController.configuration = configuration
        return viewController
    }
    
}
