//
//  UIView+AddShadow.swift
//  SportPoint
//
//  Created by Aksilont on 07.03.2023.
//

import UIKit

extension UIView {
    
    /// Добавляет тень
    /// - Parameters:
    ///   - color: Цвет тени
    ///   - opacity: Прозрачность тени
    ///   - radius: Радиус тени
    ///   - offset: Смещение тени
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.2,
                   radius: CGFloat = 0,
                   offset: CGSize = .zero) {
        
        guard let rootView = superview,
              let currentIndex = rootView.subviews.firstIndex(of: self)
        else { return }
        
        let backView = UIView(frame: frame)
        backView.backgroundColor = .white
        
        backView.layer.cornerRadius = layer.cornerRadius
        backView.layer.cornerCurve = layer.cornerCurve
        backView.layer.maskedCorners = layer.maskedCorners
        
        backView.layer.shadowColor = color.cgColor
        backView.layer.shadowOpacity = opacity
        backView.layer.shadowOffset = offset
        backView.layer.shadowRadius = radius
        
        rootView.insertSubview(backView, at: currentIndex)
    }
    
}
