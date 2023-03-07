//
//  WelcomeViewController.swift
//  SportPoint
//
//  Created by Aksilont on 06.03.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension WelcomeViewController {
    func setupView() {
        continueButton.corneredRadius(radius: 14)
        continueButton.addShadow(opacity: 0.13, radius: 6, offset: CGSize(width: 0, height: 3))
    }
}
