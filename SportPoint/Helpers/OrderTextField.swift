//
//  OrderTextField.swift
//  SportPoint
//
//  Created by Aksilont on 12.03.2023.
//

import UIKit

final class OrderTextField: UITextField {
    
    // MARK: - Insets
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        insetTextRect(forBounds: bounds)
    }
    
    private func insetTextRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 16, dy: 16)
    }
}
