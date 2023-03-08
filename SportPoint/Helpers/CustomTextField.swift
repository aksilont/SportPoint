//
//  CustomTextField.swift
//  DogStar
//
//  Created by Aksilont on 08.03.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - Insets
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += 16
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 11.5
        return textRect
    }
    
    private func insetTextRect(forBounds bounds: CGRect) -> CGRect {
        let newInset = UIEdgeInsets(top: 9, left: 38, bottom: 9, right: 39)
        let insetBounds = bounds.inset(by: newInset)
        return insetBounds
    }
    
}
