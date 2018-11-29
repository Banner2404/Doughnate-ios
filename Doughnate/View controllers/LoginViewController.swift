//
//  LoginViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.stopAnimating()
    }
    
    @IBAction private func loginButtonTap(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        activityIndicator.startAnimating()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        ApiManager.shared.login(email: email, password: password) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                switch error {
                case .smsVerificationRequired:
                    self.performSegue(withIdentifier: "showSMSSegue", sender: self)
                default:
                    self.showErrorAlert(with: "Incorrect credentials")
                }
            case .success(let token):
                let cards = [CreditCard(lastFour: "1234", brand: .visa), CreditCard(lastFour: "4242", brand: .mastercard)]
                UserManager.shared.authenticate(with: User(firstName: "123", lastName: "123", email: "etew", creditCards: cards), token: token)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFields = [emailTextField, passwordTextField]
        guard let index = textFields.firstIndex(of: textField) else { return true }
        if index < textFields.endIndex - 1 {
            textFields[index + 1]?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
