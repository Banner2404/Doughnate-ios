//
//  AccountSettingsTableViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class AccountSettingsTableViewController: UITableViewController {

    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var smsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInfo()
    }
    
    private func updateUserInfo() {
        guard let user = UserManager.shared.user else { return }
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        emailLabel.text = user.email
        smsSwitch.isOn = user.isTwoFactorAuthenticationEnabled
    }
    
    @IBAction func smsSwitchChanged(_ sender: Any) {
        if smsSwitch.isOn {
            performSegue(withIdentifier: "smsSetupSegue", sender: self)
        } else {
            guard let user = UserManager.shared.user else { return }
            guard let token = UserManager.shared.token else { return }
            ApiManager.shared.disableTwoFactorAuth(userId: user.id, token: token.accessToken) { response in
                switch response {
                case .failure(let error):
                    self.smsSwitch.isOn = true
                    self.showErrorAlert(with: "Failed to disable two factor authentication")
                case .success(let user):
                    UserManager.shared.update(user)
                }
            }
        }
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        guard let user = UserManager.shared.user else { return }
        guard let token = UserManager.shared.token?.accessToken else { return }
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        ApiManager.shared.update(firstName: firstName, lastName: lastName, userId: user.id, token: token) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to update user info")
            case .success(let user):
                UserManager.shared.update(user)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
