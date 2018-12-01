//
//  ProjectDetailsViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    var project: Project!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subscribersLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var subscriptionsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProjectInfo()
    }

}

//MARK: - Private
private extension ProjectDetailsViewController {
    
    func setupProjectInfo() {
        navigationItem.title = project.name
        titleLabel.text = project.name
        subscribersLabel.text = project.subscribersString
        descriptionLabel.text = project.description
        subscriptionsStackView.arrangedSubviews.forEach {
            subscriptionsStackView.removeArrangedSubview($0)
            subscriptionsStackView.removeFromSuperview()
        }
        project.subscriptions.forEach { subscription in
            let view = SubscriptionTypeView()
            view.titleLabel.text = subscription.title
            view.descriptionLabel.text = subscription.description
            subscriptionsStackView.addArrangedSubview(view)
        }
    }
}
