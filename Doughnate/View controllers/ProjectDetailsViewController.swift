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
    }
}
