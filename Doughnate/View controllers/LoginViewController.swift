//
//  LoginViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    
    @IBAction private func loginButtonTap(_ sender: Any) {
        UserManager.shared.authenticate(with: User(firstName: "hello", lastName: "Wordl", email: "email@test.com"),
                                        token: Token(accessToken: "hello"))
        dismiss(animated: true, completion: nil)
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
