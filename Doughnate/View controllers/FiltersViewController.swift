//
//  FiltersViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    let filters: [Category] = [.youtube, .twitter, .music]
}

//MARK: - UITableViewDataSource
extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: FilterTableViewCell.self, for: indexPath)
        let filter = filters[indexPath.row]
        cell.titleLabel.text = filter.string
        cell.categoryView.backgroundColor = filter.color
        return cell
    }
}

