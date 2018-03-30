//
//  BlurViewController.swift
//  ConnectedCare
//
//  Created by Lorraine Alexander on 6/13/17.
//  Copyright © 2017 Lorraine Alexander. All rights reserved.
//

import Foundation
import UIKit

public class BlurViewController: UIViewController {
    
    let closeButton: UIButton!
    
    public init() {
        closeButton = UIButton()
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
        view.alpha = 0.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blur)
        
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.pinSidesToSuperView()
        
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.blue, for: .normal)
        closeButton.addTarget(self, action: #selector(didTapXButton(_:)), for: .touchUpInside)
        view.addSubview(closeButton)
        view.bringSubview(toFront: closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    @objc func didTapXButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class BlurViewControllerAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        if let toViewController = toViewController as? BlurViewController {
            transitionContext.containerView.addSubview(toViewController.view)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if let toViewController = toViewController as? BlurViewController {
                toViewController.view.alpha = 1.0
            } else if let fromViewController = fromViewController as? BlurViewController {
                fromViewController.view.alpha = 0.0
            }
        }) { (_) in
            if let fromViewController = fromViewController as? BlurViewController  {
                fromViewController.view.removeFromSuperview()
            }
        }
        
        transitionContext.completeTransition(true)
    }
}

extension BlurViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurViewControllerAnimationController()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BlurViewControllerAnimationController()
    }
}
