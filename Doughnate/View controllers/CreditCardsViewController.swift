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

    private var creditCards: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCards = UserManager.shared.user?.creditCards ?? []
    }

    @IBAction private func addButtonTap(_ sender: Any) {
        let vc = STPAddCardViewController()
        vc.delegate = self
        let navc = UINavigationController(rootViewController: vc)
        present(navc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension CreditCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: CreditCardTableViewCell.self, for: indexPath)
        let card = creditCards[indexPath.row]
        cell.cardImageView.image = card.brand.image
        cell.cardLabel.text = "\(card.brand.title) card \(card.lastFour)"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CreditCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
