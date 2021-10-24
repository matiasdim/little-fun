//
//  ActivityIndicator.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 24/10/21.
//

import UIKit

class ActivityIndicator: UIViewController {
    var indicator = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        view.addSubview(indicator)
        
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
