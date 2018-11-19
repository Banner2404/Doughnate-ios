//
//  ReplaceLastSegue.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class ReplaceLastSegue: UIStoryboardSegue {
    
    override func perform() {
        guard let navigationController = source.navigationController else { return }
        var stack = navigationController.viewControllers
        stack.removeLast()
        stack.append(destination)
        navigationController.setViewControllers(stack, animated: true)
    }
}
