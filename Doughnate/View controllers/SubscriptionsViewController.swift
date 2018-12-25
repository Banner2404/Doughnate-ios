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

    var projects: [Project] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ProjectDetailsViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        vc.project = projects[indexPath.row]
    }

    func loadProjects() {
        guard let token = UserManager.shared.token?.accessToken else { return }
        ApiManager.shared.getSubscriptions(token: token) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to load subscriptions")
            case .success(let projects):
                self.projects = projects.data
                self.tableView.reloadData()
            }
        }
    }

}

//MARK: - UITableViewDataSource
extension SubscriptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: SubscriptionTableViewCell.self, for: indexPath)
        let project = projects[indexPath.row]
        cell.projectImageView.kf.setImage(with: project.imageUrl)
        cell.projectTitleLabel.text = project.name
        cell.subscriptionTitleLabel.text = project.activeSubscription(user: UserManager.shared.user?.id ?? 0)?.title
        return cell
    }
}

