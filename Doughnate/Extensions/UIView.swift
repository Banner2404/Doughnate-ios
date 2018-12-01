//
//  UIView.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/30/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadFromNib() -> UIView {
        guard let nib = getNibFile() else {
            fatalError("Unable to find nib file for \(type(of: self))")
        }
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func getNibFile() -> UINib? {
        var objectType: AnyClass? = type(of: self)
        while let type = objectType {
            let bundle = Bundle(for: type)
            let string = String(describing: type)
            if bundle.path(forResource: string, ofType: ".nib") != nil {
                return UINib(nibName: string, bundle: bundle)
            }
            objectType = type.superclass()
        }
        return nil
    }
    
    func loadAndAttach() {
        let view = loadFromNib()
        view.translatesAutoresizingMaskIntoConstraints  = false
        addSubview(view)
        view.attachToFrame(of: self)
    }
    
    func attachToFrame(of view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            ])
        
    }
}
