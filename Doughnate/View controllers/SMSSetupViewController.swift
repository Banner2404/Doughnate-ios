//
//  SMSSetupViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/29/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class SMSSetupViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //phoneNumberTextField.delegate = self
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @IBAction func enableButtonTap(_ sender: Any) {
        guard let user = UserManager.shared.user else { return }
        guard let token = UserManager.shared.token else { return }
        activityIndicator.startAnimating()
        let phone = "+375" + (phoneNumberTextField.text ?? "")
        ApiManager.shared.update(phone: phone, userId: user.id, token: token.accessToken) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to update phone")
            case .success:
                ApiManager.shared.enableTwoFactorAuth(phone: phone, userId: user.id, token: token.accessToken) { response in
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "confirmSegue", sender: nil)
                    //            switch response {
                    //            case .failure(let error):
                    //                print(error)
                    //                self.showErrorAlert(with: "Failed to enable two factor authentication")
                    //            case .success(let user):
                    //                UserManager.shared.update(user)
                    //                self.showInfoAlert(title: "Success", message: "Two factor authentication was successfully enabled") {
                    //                    self.navigationController?.popViewController(animated: true)
                    //                }
                    //            }
                }
            }
        }

    }
}

//MARK: - UITextFieldDelegate
extension SMSSetupViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldString = (textField.text ?? "") as NSString
        let newString = oldString.replacingCharacters(in: range, with: string)
        if newString.starts(with: "+375") {
            textField.text = String(newString.dropFirst(4))
        }
        return false
    }
}
