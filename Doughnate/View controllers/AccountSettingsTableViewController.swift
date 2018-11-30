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
        }
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        guard var user = UserManager.shared.user else { return }
        guard let token = UserManager.shared.token?.accessToken else { return }
        user.firstName = firstNameTextField.text ?? ""
        user.lastName = lastNameTextField.text ?? ""
        ApiManager.shared.update(user: user, token: token) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to update user info")
            case .success:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
