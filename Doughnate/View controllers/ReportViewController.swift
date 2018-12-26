//
//  ReportViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/1/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    var project: Project!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10.0
    }
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonTap(_ sender: Any) {
        guard let token = UserManager.shared.token?.accessToken else { return }
        let message = textField.text ?? ""
        ApiManager.shared.report(projectId: project.id, message: message, token: token) { response in
            switch response {
            case .failure(let error):
                self.showInfoAlert(title: "Thanks", message: "Your message will be reviewed shortly") {
                    self.dismiss(animated: true, completion: nil)
                }
            case .success:
                self.showInfoAlert(title: "Thanks", message: "Your message will be reviewed shortly") {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
