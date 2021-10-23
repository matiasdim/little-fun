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
        
        let home = embedInNavigation(viewController: createHomeScreen(), title: "Home", iconName: "home")
        let favorites = embedInNavigation(viewController: createFavoritesScreen(), title: "favorites", iconName: "Favorites")
        viewControllers = [home, favorites]
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
    
    private func createHomeScreen() -> UIViewController {
        let homePage = ItemsTableViewController(itemsVM: ItemsViewModel())
        homePage.navigationItem.largeTitleDisplayMode = .always
        homePage.title = "Home"
        return homePage
    }
    
    private func createFavoritesScreen() -> UIViewController {
        let favoritesPage = ItemsTableViewController(itemsVM: ItemsViewModel())
        favoritesPage.navigationItem.largeTitleDisplayMode = .always
        favoritesPage.title = "Favorites"
        return favoritesPage
    }
    
    private func embedInNavigation(viewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.tabBarItem.image = UIImage(systemName: iconName, withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        navVC.tabBarItem.title = title
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }

}
