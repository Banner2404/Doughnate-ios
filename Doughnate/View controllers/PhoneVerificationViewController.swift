//
//  PhoneVerificationViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class PhoneVerificationViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var codeTextField: UITextField!
    
    @IBAction private func submitButtonTap(_ sender: Any) {
        let code = codeTextField.text ?? ""
        activityIndicator.startAnimating()
        ApiManager.shared.loginSMS(code: code) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Incorrect code")
            case .success(let token):
                UserManager.shared.authenticate(with: User(firstName: "123", lastName: "123", email: "etew"), token: token)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
