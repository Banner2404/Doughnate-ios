//
//  CreditCardsViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/29/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit
import Stripe

class CreditCardsViewController: UIViewController {


    @IBAction private func addButtonTap(_ sender: Any) {
        let vc = STPAddCardViewController()
        vc.delegate = self
        let navc = UINavigationController(rootViewController: vc)
        present(navc, animated: true, completion: nil)
    }
}

//MARK: - STPAddCardViewControllerDelegate
extension CreditCardsViewController: STPAddCardViewControllerDelegate {
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        print(token)
        dismiss(animated: true, completion: nil)
    }

}
