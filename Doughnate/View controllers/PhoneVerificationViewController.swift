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
            case .success(let account):
                UserManager.shared.authenticate(with: account)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
