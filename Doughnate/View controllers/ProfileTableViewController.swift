//
//  ProfileTableViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var logOutCell: UITableViewCell!
    
    private func logOutTap() {
        let alert = UIAlertController(title: "Log out?", message: "Are you sure want to log out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            UserManager.shared.unauthenticate()
            (self.tabBarController as? TabBarController)?.showLoginScreen()
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.preferredAction = noAction
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath) == logOutCell {
            logOutTap()
        }
    }
}
