//
//  ChangePasswordViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/30/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var textFields: [UITextField] {
        return [currentPasswordTextField, newPasswordTextField, repeatPasswordTextField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPasswordTextField.becomeFirstResponder()
    }
    
    @IBAction func changeButtonTap(_ sender: Any) {
        let oldPassword = currentPasswordTextField.text ?? ""
        let newPassword = newPasswordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        
        
        if newPassword != repeatPassword {
            showErrorAlert(with: "Passwords do not match")
            return
        }
        activityIndicator.startAnimating()
        ApiManager.shared.changePassword(old: oldPassword, new: newPassword) { response in
            self.activityIndicator.stopAnimating()
            switch response {
            case .failure(let error):
                print(error)
                self.showInfoAlert(title: "Success", message: "Password was successfully changed")
                self.navigationController?.popViewController(animated: true)
            case .success:
                self.showInfoAlert(title: "Success", message: "Password was successfully changed")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension ChangePasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFields.firstIndex(of: textField) else { return true }
        if index < textFields.endIndex - 1 {
            textFields[index + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
