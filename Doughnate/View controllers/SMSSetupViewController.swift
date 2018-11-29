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
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @IBAction func enableButtonTap(_ sender: Any) {
        print(phoneNumberTextField.text)
        activityIndicator.startAnimating()
    }
}
