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
    var user: Int!
    var displayedSubscriptions: [SubscriptionType] {
        if let sub = project.activeSubscription(user: user) {
            return [sub]
        } else {
            return project.subscriptions
        }
    }
    var displayedPosts: [Post] {
        if project.isSubscribed(user: user) {
            return project.posts
        } else {
            return project.posts.filter { $0.isPublic }
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subscribersLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var subscriptionsStackView: UIStackView!
    @IBOutlet private weak var subscriptionsTitle: UILabel!
    @IBOutlet private weak var unsubscribeButton: UIButton!
    @IBOutlet private weak var postsStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserManager.shared.user?.id
        setupProjectInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navc = segue.destination as? UINavigationController else { return }
        guard let vc = navc.viewControllers.first as? ReportViewController else { return }
        vc.project = project
    }
    @IBAction func unsubscribeButtonTap(_ sender: Any) {
        showAlert(title: "Unsubscribe?", message: "Do you want to unsubscribe from \(project.name)") {
            self.unsubscribe()
        }
    }

    func unsubscribe() {
        guard let token = UserManager.shared.token?.accessToken else { return }
        ApiManager.shared.unsubscribe(projectId: project.id, token: token) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Unable to unsubscribe")
            case .success:
                self.reloadProject()
            }
        }
    }
    
}

//MARK: - Private
private extension ProjectDetailsViewController {
    
    func setupProjectInfo() {
        navigationItem.title = project.name
        titleLabel.text = project.name
        unsubscribeButton.isHidden = !project.isSubscribed(user: user)
        subscriptionsTitle.text = project.isSubscribed(user: user) ? "You are Subscribed" : "Subscriptions"
        subscribersLabel.text = project.subscribersString
        descriptionLabel.text = project.description
        subscriptionsStackView.arrangedSubviews.forEach {
            subscriptionsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        displayedSubscriptions.forEach {
            subscriptionsStackView.addArrangedSubview(createSubscriptionView(for: $0))
        }

        postsStackView.arrangedSubviews.forEach {
            postsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        displayedPosts.forEach {
            postsStackView.addArrangedSubview(createPostView(for: $0))
        }
    }

    func reloadProject() {
        ApiManager.shared.getProject(id: project.id, token: UserManager.shared.token?.accessToken) { response in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let project):
                self.project = project
                self.setupProjectInfo()
            }
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

    func createPostView(for post: Post) -> PostView {
        let view = PostView()
        view.descriptionLabel.text = post.text
        return view
    }
    
    @objc
    func subscriptionCellTap(_ recognizer: UIGestureRecognizer) {
        guard !project.isSubscribed(user: user) else { return }
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
                    self.reloadProject()
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
