//
//  ViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinnerView: UIStackView!
    private var projects: [Project] = []
    
    override func viewDidLoad() {
        loadProjects()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ProjectDetailsViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        destination.project = projects[indexPath.section]
    }
    
    
}

//MARK: - Private
private extension ProjectListViewController {
    
    @objc
    func reloadData() {
        ApiManager.shared.getProjects { response in
            self.tableView.refreshControl?.endRefreshing()
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to load projects")
            case .success(let projects):
                self.projects = projects
                self.tableView.reloadData()
            }
        }
    }
    
    func loadProjects() {
        tableView.isHidden = true
        spinnerView.isHidden = false
        ApiManager.shared.getProjects { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to load projects")
            case .success(let projects):
                self.tableView.isHidden = false
                self.spinnerView.isHidden = true
                self.projects = projects
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ProjectListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ProjectTableViewCell.self, for: indexPath)
        let project = projects[indexPath.section]
        cell.projectImageView.kf.setImage(with: project.imageUrl)
        cell.projectNameLabel.text = project.name
        cell.descriptionLabel.text = project.description
        cell.subscribersLabel.text = project.subscribersString
        cell.categoryView.backgroundColor = project.category.color
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ProjectListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}

