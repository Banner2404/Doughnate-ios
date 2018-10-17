//
//  UITableView.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        let id = type.identifier
        guard let cell = dequeueReusableCell(withIdentifier: id, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier " + id)
        }
        return cell
    }
    
    func deselectAllRows(animated: Bool) {
        indexPathsForSelectedRows?.forEach { deselectRow(at: $0, animated: animated) }
    }
    
    func selectAllRows(animated: Bool) {
        (0..<numberOfSections).forEach { section in
            (0..<numberOfRows(inSection: section)).forEach { row in
                let indexPath = IndexPath(row: row, section: section)
                selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
        }
    }
}
