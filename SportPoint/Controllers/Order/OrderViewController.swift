//
//  OrderViewController.swift
//  SportPoint
//
//  Created by Aksilont on 11.03.2023.
//

import UIKit

final class OrderViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: OrderTextField!
    @IBOutlet weak var phoneTextField: OrderTextField!
    @IBOutlet weak var emailTextField: OrderTextField!
    @IBOutlet weak var orderButton: UIButton!
    
    // MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - UI
    
    private func setupView() {
        nameTextField.corneredRadius(radius: 10)
        phoneTextField.corneredRadius(radius: 10)
        emailTextField.corneredRadius(radius: 10)
        
        orderButton.corneredRadius(radius: 14)
        orderButton.addShadow(opacity: 0.13, radius: 6, offset: CGSize(width: 0, height: 3))

        navigationController?.isNavigationBarHidden = false
        let backArrowImage = UIImage(named: "BackArrow")?.withRenderingMode(.alwaysOriginal)
        let backItem = UIBarButtonItem(image: backArrowImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(backDidTap))
        navigationItem.leftBarButtonItem = backItem
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(gesture)
    }
    
    // MARK: - Actions
    
    @objc private func backDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func viewDidTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func orderDidTAP(_ sender: UIButton) {
        guard Validators.isFilled(nameTextField.text,
                                  phoneTextField.text,
                                  emailTextField.text)
        else {
            showAlert(title: "Ошибка", message: "Заполните пустые поля")
            return
        }
        
        guard Validators.isSimpleEmail(emailTextField.text ?? "")
        else {
            showAlert(title: "Ошибка", message: "Проверьте корректность ввода почты")
            return
        }
        
        showAlert(
            title: "Успешно",
            message: "Ваша заявка будет рассмотрена, мы с вами свяжемся") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
    }
    
}
