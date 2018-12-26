//
//  ViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit
import Kingfisher

class ProjectListViewController: UITableViewController, UISearchResultsUpdating {

    private var projects: [Project] = []
    private var selectedFilters: [String] = []
    private var visibleProjects: [Project] {
        if selectedFilters.isEmpty {
            return projects
        } else {
            return projects.filter { selectedFilters.contains($0.category) }
        }
    }

    override func viewDidLoad() {
        loadProjects("")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProjectDetailsViewController {
            guard let cell = sender as? UITableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            destination.project = visibleProjects[indexPath.section]
        } else if let destination = segue.destination as? FiltersViewController {
            let filters = Array(Set(projects.map { $0.category }))
            destination.filters = filters
        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return visibleProjects.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ProjectTableViewCell.self, for: indexPath)
        let project = visibleProjects[indexPath.section]
        cell.projectImageView.kf.setImage(with: project.imageUrl)
        cell.projectNameLabel.text = project.name + " is creating " + project.category
        cell.descriptionLabel.text = project.description
        cell.subscribersLabel.text = project.subscribersString
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }

    func reloadFilters(filters: [String]) {
        selectedFilters = filters
        tableView.reloadData()
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        loadProjects(text)
    }
}

//MARK: - Private
private extension ProjectListViewController {
    
    @objc
    func reloadData() {
        loadProjects(navigationItem.searchController?.searchBar.text ?? "")
    }
    
    func loadProjects(_ text: String) {
        ApiManager.shared.getProjects(token: UserManager.shared.token?.accessToken) { response in
            switch response {
            case .failure(let error):
                print(error)
                self.showErrorAlert(with: "Failed to load projects")
            case .success(let projects):
                let visible = text.isEmpty ? projects : projects.filter { $0.name.lowercased().contains(text.lowercased()) }
                self.projects = visible
                self.tableView.reloadData()
            }
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
