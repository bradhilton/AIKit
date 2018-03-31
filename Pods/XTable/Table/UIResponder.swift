//
//  UIResponder.swift
//  Table
//
//  Created by Bradley Hilton on 3/23/18.
//  Copyright © 2018 Brad Hilton. All rights reserved.
//

extension UIResponder {
    
    var viewController: UIViewController? {
        return (self as? UIViewController) ?? next?.viewController
    }
    
}
