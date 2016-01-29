//
//  CustomTextField.swift
//  DentiPad
//
//  Created by Liliana on 28/10/15.
//  Copyright (c) 2015 Liliana Sirbu. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomTextField: UITextField {
    @IBInspectable public var insetX: CGFloat = 0
    @IBInspectable public var insetY: CGFloat = 0
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, insetY)
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, insetY)
    }

    @IBInspectable public var borderCol : UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderCol.CGColor
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var backgroundCol : UIColor = UIColor.clearColor() {
        didSet {
            layer.backgroundColor = backgroundCol.CGColor
            layer.masksToBounds = false
        }
    }

}
