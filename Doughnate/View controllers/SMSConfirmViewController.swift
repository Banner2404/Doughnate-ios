//
//  PhoneVerificationViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class SMSConfirmViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var codeTextField: UITextField!

    @IBAction private func submitButtonTap(_ sender: Any) {
        guard let token = UserManager.shared.token?.accessToken else { return }
        let code = codeTextField.text ?? ""
        activityIndicator.startAnimating()
        ApiManager.shared.confirmTwoFactor(code: code, token: token) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Incorrect code")
            case .success:
                if var user = UserManager.shared.user {
                    user.isTwoFactorAuthenticationEnabled = true
                    UserManager.shared.update(user)
                }
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
