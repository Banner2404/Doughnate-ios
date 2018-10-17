//
//  ViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinnerView: UIStackView!
    private var projects: [Project] = []
    
    override func viewDidLoad() {
        loadProjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ProjectDetailsViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        destination.project = projects[indexPath.row]
    }
}

//MARK: - Private
private extension ProjectListViewController {
    
    func loadProjects() {
        tableView.isHidden = true
        spinnerView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.isHidden = false
            self.spinnerView.isHidden = true
            self.projects = [
                Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 123456789, category: .youtube),
                Project.init(name: "Elon Musk", description: "Business magnate and investor", subscribers: 100, category: .twitter),
                Project.init(name: "Taylow Swift", description: "Music", subscribers: 63243, category: .music),
                Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 10, category: .youtube),
                Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 9354235432, category: .youtube),
                Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 9343233, category: .youtube)]
            
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension ProjectListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ProjectTableViewCell.self, for: indexPath)
        let project = projects[indexPath.row]
        cell.projectNameLabel.text = project.name
        cell.descriptionLabel.text = project.description
        cell.subscribersLabel.text = project.subscribersString
        cell.categoryView.backgroundColor = project.category.color
        return cell
    }
}

