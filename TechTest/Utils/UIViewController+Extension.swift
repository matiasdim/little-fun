//
//  UIViewController+Extension.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import UIKit


extension UIViewController {
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, action: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(action)
        show(alertController, sender: self)
    }
}
