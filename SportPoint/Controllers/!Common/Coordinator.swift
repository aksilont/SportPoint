//
//  Coordinator.swift
//  MyNews
//
//  Created by Aksilont on 15.02.2023.
//

import UIKit

final class Coordinator {
    static let shared = Coordinator()
    
    private init() {}
    
    func goTo(_ destination: UIViewController, useNavigationController: Bool = true) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window
        else { return }
        
        if useNavigationController {
            let navigationVC = UINavigationController(rootViewController: destination)
            navigationVC.navigationBar.prefersLargeTitles = true
            window.rootViewController = navigationVC
        } else {
            window.rootViewController = destination
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    }
}
