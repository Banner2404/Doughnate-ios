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
        project.subscriptions.forEach {
            subscriptionsStackView.addArrangedSubview(createSubscriptionView(for: $0))
        }
    }
    
    func createSubscriptionView(for subscription: SubscriptionType) -> SubscriptionTypeView {
        let view = SubscriptionTypeView()
        view.titleLabel.text = subscription.title
        view.descriptionLabel.text = subscription.description
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(subscriptionCellTap))
        view.addGestureRecognizer(tap)
        return view
    }
    
    @objc
    func subscriptionCellTap(_ recognizer: UIGestureRecognizer) {
        guard let cell = recognizer.view else { return }
        guard let index = subscriptionsStackView.arrangedSubviews.firstIndex(of: cell) else { return }
        let subscription = project.subscriptions[index]
        subscribe(to: subscription)
    }
    
    func subscribe(to subscription: SubscriptionType) {
        let alert = UIAlertController(title: "Subscribe?", message: "Do you want to subscribe to $\(subscription.amount) plan?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            print(subscription)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        present(alert, animated: true, completion: nil)
    }
}
