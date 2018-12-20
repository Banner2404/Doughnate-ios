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
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
    }

    @IBAction private func addButtonTap(_ sender: Any) {
        let vc = STPAddCardViewController()
        vc.delegate = self
        let navc = UINavigationController(rootViewController: vc)
        present(navc, animated: true, completion: nil)
    }

    func loadCards() {
        guard let token = UserManager.shared.token?.accessToken else { return }
        ApiManager.shared.getCards(token: token) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to load cards")
            case .success(let cards):
                self.creditCards = cards
                self.tableView.reloadData()
            }
        }
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let accessToken = UserManager.shared.token?.accessToken else { return }
        let card = creditCards[indexPath.row]
        ApiManager.shared.deleteCard(id: card.id, token: accessToken) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to delete card")
            case .success:
                self.creditCards.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
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
        guard let accessToken = UserManager.shared.token?.accessToken else { return }
        ApiManager.shared.addCard(stripeToken: token.tokenId, token: accessToken) { response in

            switch response {
            case .failure(let error):
                self.loadCards()
                self.dismiss(animated: true, completion: nil)
            case .success(let card):
                self.creditCards.append(card)
                self.tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
