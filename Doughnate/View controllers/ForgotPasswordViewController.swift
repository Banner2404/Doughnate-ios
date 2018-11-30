//
//  ForgotPasswordViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/30/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func restoreButtonTap(_ sender: Any) {
        let email = emailTextField.text ?? ""
        activityIndicator.startAnimating()
        ApiManager.shared.forgotPassword(email: email) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to reset password")
            case .success:
                self.showErrorAlert(with: "Check your email for reset link") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
