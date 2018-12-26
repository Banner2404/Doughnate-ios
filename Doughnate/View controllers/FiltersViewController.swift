//
//  FiltersViewController.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    var filters: [String] = []
    @IBOutlet private weak var tableView: UITableView!

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let listVC = navigationController?.viewControllers.compactMap { $0 as? ProjectListViewController }.first
        let selectedFilters = tableView.indexPathsForSelectedRows?.map { filters[$0.row] } ?? []
        listVC?.reloadFilters(filters: selectedFilters)
    }
    
    @IBAction private func allButtonTap(_ sender: Any) {
        if tableView.indexPathsForSelectedRows?.count == filters.count {
            tableView.deselectAllRows(animated: true)
        } else {
            tableView.selectAllRows(animated: true)
        }
    }
}

//MARK: - UITableViewDataSource
extension FiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: FilterTableViewCell.self, for: indexPath)
        let filter = filters[indexPath.row]
        cell.titleLabel.text = filter
        return cell
    }
}

