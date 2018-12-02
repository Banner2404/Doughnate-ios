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
    var displayedSubscriptions: [SubscriptionType] {
        if let sub = project.activeSubscription {
            return [sub]
        } else {
            return project.subscriptions
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subscribersLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var subscriptionsStackView: UIStackView!
    @IBOutlet private weak var subscriptionsTitle: UILabel!
    @IBOutlet private weak var unsubscribeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProjectInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navc = segue.destination as? UINavigationController else { return }
        guard let vc = navc.viewControllers.first as? ReportViewController else { return }
        vc.project = project
    }
    @IBAction func unsubscribeButtonTap(_ sender: Any) {
        showAlert(title: "Unsubscribe?", message: "Do you want to unsubscribe from \(project.name)") {
            print("Cancel")
        }
    }
    
}

//MARK: - Private
private extension ProjectDetailsViewController {
    
    func setupProjectInfo() {
        navigationItem.title = project.name
        titleLabel.text = project.name
        unsubscribeButton.isHidden = !project.isSubscribed
        subscriptionsTitle.text = project.isSubscribed ? "You are Subscribed" : "Subscriptions"
        subscribersLabel.text = project.subscribersString
        descriptionLabel.text = project.description
        subscriptionsStackView.arrangedSubviews.forEach {
            subscriptionsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        displayedSubscriptions.forEach {
            subscriptionsStackView.addArrangedSubview(createSubscriptionView(for: $0))
        }
    }
    
    func createSubscriptionView(for subscription: SubscriptionType) -> SubscriptionTypeView {
        let view = SubscriptionTypeView()
        view.titleLabel.text = subscription.title + ":"
        view.descriptionLabel.text = subscription.description
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(subscriptionCellTap))
        view.addGestureRecognizer(tap)
        return view
    }
    
    @objc
    func subscriptionCellTap(_ recognizer: UIGestureRecognizer) {
        guard !project.isSubscribed else { return }
        guard let cell = recognizer.view else { return }
        guard let index = subscriptionsStackView.arrangedSubviews.firstIndex(of: cell) else { return }
        let subscription = project.subscriptions[index]
        subscribe(to: subscription)
    }
    
    func subscribe(to subscription: SubscriptionType) {
        showAlert(title: "Subscribe?", message: "Do you want to subscribe to $\(subscription.amount) plan?") {
            guard let token = UserManager.shared.token?.accessToken else { return }
            ApiManager.shared.subscribe(projectId: self.project.id, subscriptionId: subscription.id, token: token, completion: { response in
                switch response {
                case .failure(let error):
                    print(error)
                    self.showErrorAlert(with: "Failed to subscribe")
                case .success:
                    self.project.activeSubscription = subscription
                    self.setupProjectInfo()
                }
            })
        }
    }
    
    func showAlert(title: String, message: String, onYes: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            onYes()
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
}
