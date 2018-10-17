//
//  ViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {

    let projects: [Project] = [
        Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 123456789),
        Project.init(name: "Elon Musk", description: "Business magnate and investor", subscribers: 100),
        Project.init(name: "Taylow Swift", description: "Music", subscribers: 63243),
        Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 10),
        Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 9354235432),
        Project.init(name: "Wylsacom", description: "Best tech channel about iPhones", subscribers: 9343233)]
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
        cell.subscribersLabel.text = project.subscribers.shortString + " subscribers"
        return cell
    }
}

