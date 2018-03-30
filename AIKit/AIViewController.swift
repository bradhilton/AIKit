//
//  AIViewController.swift
//  AIKit
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit

public protocol AIViewControllerDelegate: class {
    func didDismiss()
}

public class AIViewController: UIViewController {
    
    public weak var delegate: AIViewControllerDelegate?
    
    private var configuration: AIConfiguration!
    
    @IBOutlet weak var aiViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var aiView: UIView!
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public class func create(with configuration: AIConfiguration) -> AIViewController {
        let storyboard = UIStoryboard(name: "AIKit", bundle: Bundle(for: AIViewController.self))
        let viewController = storyboard.instantiateInitialViewController() as! AIViewController
        viewController.configuration = configuration
        viewController.transitioningDelegate = viewController
        viewController.modalPresentationStyle = .custom
        
        return viewController
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView.effect = blurEffect
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true) {
            DispatchQueue.main.async {
                self.delegate?.didDismiss()
            }
        }
    }
}

class AIViewControllerAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        if let toViewController = toViewController as? AIViewController {
            transitionContext.containerView.addSubview(toViewController.view)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if let toViewController = toViewController as? AIViewController {
                toViewController.view.alpha = 1.0

            } else if let fromViewController = fromViewController as? AIViewController {
                fromViewController.view.alpha = 0.0
            }
        }) { (_) in
            if let fromViewController = fromViewController as? AIViewController  {
                fromViewController.view.removeFromSuperview()
            } else if let toViewController = toViewController as? AIViewController {
                UIView.animate(withDuration: 0.2, animations: {
                    toViewController.aiView.alpha = 1.0
                    toViewController.view.layoutSubviews()
                })
                
            }
        }
        
        transitionContext.completeTransition(true)
    }
}

extension AIViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AIViewControllerAnimationController()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AIViewControllerAnimationController()
    }
}
