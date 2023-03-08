//
//  UIViewController+GetFromStoryboard.swift
//  MyNews
//
//  Created by Aksilont on 18.02.2023.
//

import UIKit

extension UIViewController {
    
    static func getFromStoryboard(_ name: String = "Main", withIdentifier: String = "") -> Self {
        let identifier = withIdentifier.isEmpty ? String(describing: Self.self) : withIdentifier

        guard let viewController = UIStoryboard(name: name, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? Self
        else { return Self.init() }

        return viewController
    }
    
    static func getFromXIB() -> Self {
        Self.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    static func getFromXIB<T: UIViewController>(type: T.Type) -> T {
        T(nibName: String(describing: T.self), bundle: nil)
    }

}
