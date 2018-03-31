//
//  AIViewController.swift
//  AIKit
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import Lottie

public protocol AIViewControllerDelegate: class {
    func didDismiss()
}

public class AIViewController: UIViewController {
    
    
    @IBOutlet weak var waveView: WaveView!
    public weak var delegate: AIViewControllerDelegate?
    
    private var configuration: AIConfiguration!
    
    @IBOutlet weak var aiViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var aiViewWidth: NSLayoutConstraint!
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
        waveView.update(with: 0.5)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        if let toViewController = toViewController as? AIViewController {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toViewController.view.alpha = 1.0
            }) { (_) in
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    toViewController.aiViewHeight.constant = 600
                    toViewController.aiViewWidth.constant = toViewController.view.frame.size.width*0.9
                    toViewController.view.layoutSubviews()
                }, completion: nil)
            }
        } else if let fromViewController = fromViewController as? AIViewController {
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                fromViewController.aiViewHeight.constant = 0
                fromViewController.aiViewWidth.constant = 0
                toViewController.view.layoutSubviews()
            }) { (_) in
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                    fromViewController.view.alpha = 0.0
                })
            }
        }
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            if let toViewController = toViewController as? AIViewController {
//                toViewController.view.alpha = 1.0
//
//            } else if let fromViewController = fromViewController as? AIViewController {
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                    fromViewController.aiViewHeight.constant = 0
//                    fromViewController.aiViewWidth.constant = 0
//                    toViewController.view.layoutSubviews()
//                }, completion: nil)
//            }
//        }) { (_) in
//            if let fromViewController = fromViewController as? AIViewController  {
//                fromViewController.view.removeFromSuperview()
//            } else if let toViewController = toViewController as? AIViewController {
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                    toViewController.aiViewHeight.constant = 600
//                    toViewController.aiViewWidth.constant = toViewController.view.frame.size.width*0.9
//                    toViewController.view.layoutSubviews()
//                }, completion: nil)
//            }
//        }
        
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
