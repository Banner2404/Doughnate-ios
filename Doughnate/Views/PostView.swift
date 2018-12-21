//
//  PostView.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

class PostView: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

//MARK: - Private
private extension PostView {

    func setup() {
        loadAndAttach()
    }
}
