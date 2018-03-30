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

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = createAIButton(target: self, action: #selector(didTapAIButton))
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(button)
        
    }
    @objc
    func didTapAIButton() -> () {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

