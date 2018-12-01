//
//  UIViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showInfoAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in completion?() })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(with message: String, completion: (() -> Void)? = nil) {
        showInfoAlert(title: "Error", message: message)
    }
}
