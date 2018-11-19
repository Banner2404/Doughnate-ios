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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInfo()
    }
    
    private func updateUserInfo() {
        guard let user = UserManager.shared.user else { return }
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        emailLabel.text = user.email
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
