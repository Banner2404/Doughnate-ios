//
//  TabBarController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shared.restoreCredentials()
        if !UserManager.shared.isAuthenticated {
            DispatchQueue.main.async {
                self.showLoginScreen()
            }
        }
    }
    
    func showLoginScreen() {
        performSegue(withIdentifier: "ShowLoginSegue", sender: self)
    }
}
