//
//  UIViewExtension.swift
//  ConnectedCare
//
//  Created by Lorraine Alexander on 2/22/17.
//  Copyright © 2017 Lorraine Alexander. All rights reserved.
//

import UIKit

let PDFSize = CGSize(width: 851, height: 612)

public class RoundedView: UIView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = true
    }
}

public class RoundedButton: UIButton {
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = false
    }
}

public class RoundedLabel: UILabel {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = true
    }
}

public class RoundedImageView: UIImageView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width/2
        layer.masksToBounds = true
    }
}

extension UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0

        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var shadowColor: UIColor {
        get {
            guard let currentShadowColor = layer.borderColor else { return UIColor.white }
            return UIColor(cgColor: currentShadowColor)
        }
        set {
            layer.shadowColor = newValue.cgColor
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let currentBorderColor = layer.borderColor else { return UIColor.white }
            return UIColor(cgColor: currentBorderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
            layer.masksToBounds = true
        }
    }
    
    @discardableResult
    public func pinSidesToSuperView(with margin: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] {
        guard let superview = superview else { return [] }
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1.0, constant: margin.top)
        constraints.append(top)
        superview.addConstraint(top)
        
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1.0, constant: -margin.bottom)
        constraints.append(bottom)
        superview.addConstraint(bottom)
        
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1.0, constant: margin.left)
        constraints.append(leading)
        superview.addConstraint(leading)
        
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1.0, constant: -margin.right)
        constraints.append(trailing)
        superview.addConstraint(trailing)
        
        return constraints
    }
    
    func toPDF(with name: String) -> NSData {
        
        let scale = PDFSize.width/frame.size.width
        
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: PDFSize.width, height: PDFSize.height), nil)
        UIGraphicsBeginPDFPage()
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return pdfData }
        
        
        let rescale: CGFloat = scale*4
        
        func scaler(view: UIView) {
            if !(view is UIStackView)  {
                view.contentScaleFactor = scale*8
            }
            for subview in view.subviews {
                scaler(view: subview)
            }
        }
        scaler(view: self)
        
        // Create a large Image by rendering the scaled view
        let bigSize = CGSize(width: PDFSize.width*rescale, height: PDFSize.height*rescale)
        UIGraphicsBeginImageContextWithOptions(bigSize, true, 1)
        guard let context = UIGraphicsGetCurrentContext() else { return pdfData }
        
        context.setFillColor(UIColor.white.cgColor)
        context.fill(CGRect(origin: CGPoint(x: 0, y: 0), size: bigSize))
        
        // Must increase the transform scale
        context.scaleBy(x: rescale, y: rescale)
        
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        pdfContext.saveGState()
        pdfContext.translateBy(x: frame.origin.x, y: frame.origin.y) // where the view should be shown
        
        pdfContext.scaleBy(x: scale/rescale, y: scale/rescale)
        
        let newFrame: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: bigSize)
        image?.draw(in: newFrame)
        
        pdfContext.restoreGState()
//        context.scaleBy(x: scale, y: scale)
//        layer.render(in: context)
        UIGraphicsEndPDFContext()
        
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + "\(name).pdf"
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
        
        return pdfData
    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        layer.cornerRadius = cornerRadius
    //
//        layer.borderColor = borderColor
//        layer.borderWidth = borderWidth
//        
////        layer.shadowOffset = CGSize(width: 3, height: 3)
////        layer.shadowOpacity = 0.7
////        layer.shadowRadius = 2
//        
//        layer.masksToBounds = true
//    }
}
