//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        // swiftlint:disable force_cast
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil)?.first as! T
    }

    enum GradientDirectionType {
        case left
        case right
        case top
        case bottom
    }
    
    func makeGradient(colors: [UIColor], direction: GradientDirectionType) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        
        gradient.colors = colors.map({ color in
            return color.cgColor
        })
        switch direction {
        case .left:
            gradient.startPoint = .init(x: 1.0, y: 0.5)
            gradient.endPoint = .init(x: 0.0, y: 0.5)
        case .right:
            gradient.startPoint = .init(x: 0.0, y: 0.5)
            gradient.endPoint = .init(x: 1.0, y: 0.5)
        case .top:
            gradient.startPoint = .init(x: 0.5, y: 1.0)
            gradient.endPoint = .init(x: 0.5, y: 0.0)
        case .bottom:
            gradient.startPoint = .init(x: 0.5, y: 0.0)
            gradient.endPoint = .init(x: 0.5, y: 1.0)
        }
        
        self.layer.addSublayer(gradient)
    }
}

@IBDesignable
extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let shadowColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: shadowColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
            clipsToBounds = !(newValue != nil)
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}
