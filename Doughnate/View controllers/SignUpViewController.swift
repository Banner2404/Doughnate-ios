//
//  SignUpViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
 
    @IBAction private func signUpButtonTap(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordConfirmation = repeatPasswordTextField.text ?? ""
        signUp(email: email, password: password, passwordConfirmation: passwordConfirmation)
    }
    
    private func signUp(email: String, password: String, passwordConfirmation: String) {
        if password != passwordConfirmation {
            showErrorAlert(with: "Passwords do not match")
        }
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
        activityIndicator.startAnimating()
        ApiManager.shared.signup(email: email, password: password) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to sign up")
            case .success:
                self.showErrorAlert(with: "Please confirm your email address") {
                    self.performSegue(withIdentifier: "showLoginSegue", sender: self)
                }
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFields = [emailTextField, passwordTextField, repeatPasswordTextField]
        guard let index = textFields.firstIndex(of: textField) else { return true }
        if index < textFields.endIndex - 1 {
            textFields[index + 1]?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
