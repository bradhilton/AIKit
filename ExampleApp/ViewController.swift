//
//  ViewController.swift
//  ExampleApp
//
//  Created by Bradley Hilton on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import AIKit

class ViewController: UIViewController {
    
//    let configuration = AIConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func didTapAIButton(_ sender: Any) {
        let viewController = AIViewController.create(with: AIConfiguration())
        viewController.delegate = self
        present(viewController, animated: true) {
            self.aiButton.isHidden = true
        }
    }
    
    @IBOutlet weak var aiButton: RoundedButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: AIViewControllerDelegate {
    func didDismiss() {
        self.aiButton.isHidden = false
    }
}

