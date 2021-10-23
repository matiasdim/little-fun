//
//  TabBarViewController.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//


/// text can be better architectured ti easily add localization

import UIKit

class TabBarViewController: UITabBarController {
    
    var loginVC: LoginViewController?
    var loginVM: LoginViewModel?
    
    init(loginVM: LoginViewModel? = nil) {
        self.loginVM = loginVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoginViewControllerIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let loginVC = loginVC else { return }

        show(loginVC, sender: self)
    }
    
    private func createLoginViewControllerIfNeeded() {
        if let loginVM = loginVM {
            loginVC = LoginViewController(loginVM: loginVM)
        }        
    }

}
