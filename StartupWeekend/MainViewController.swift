//
//  MainViewController.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import AIKit

class MainViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
    }
    
    @IBOutlet weak var aiButton: UIButton!
    
    @IBAction func didTapAIButton(_ sender: Any) {
        let configuration = AIConfiguration()
        configuration.initialSections = [howToSection()]
        configuration.appName = "the Startup Weekend app"
        let aiViewController = AIViewController.create(with: configuration)
        aiViewController.delegate = self
        present(aiViewController, animated: true) {
            self.aiButton.isHidden = true
        }
    }
    
}

extension MainViewController: AIViewControllerDelegate {
    
    func didDismiss() {
        self.aiButton.isHidden = false
    }
    
    func aiResponse(for witResponse: WitResponse) -> AIResponse {
        return AIResponse(for: witResponse)
    }
    
}
