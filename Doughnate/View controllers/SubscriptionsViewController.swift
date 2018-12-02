//
//  SubscriptionsViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/2/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit
import Kingfisher

class SubscriptionsViewController: UIViewController {

    let subscriptions: [Subscription] = [Subscription(project: Project(), subscriptionType: SubscriptionType())]
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ProjectDetailsViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let subscription = subscriptions[indexPath.row]
        vc.project = subscription.project
    }

}

//MARK: - UITableViewDataSource
extension SubscriptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: SubscriptionTableViewCell.self, for: indexPath)
        let subscription = subscriptions[indexPath.row]
        cell.projectImageView.kf.setImage(with: subscription.project.imageUrl)
        cell.projectTitleLabel.text = subscription.project.name
        cell.subscriptionTitleLabel.text = subscription.subscriptionType.title
        return cell
    }
}

