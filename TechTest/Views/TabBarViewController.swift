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
    
    init(loginVC: LoginViewController? = nil) {
        self.loginVC = loginVC
        super.init(nibName: nil, bundle: nil)
        viewControllers = [createHomeScreen(), createFavoritesScreen()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let loginVC = loginVC else { return }

        show(loginVC, sender: self)
    }
    
    private func createHomeScreen() -> UINavigationController {
        let title = "Top Movies"
        return embedInNavigation(viewController: crateItemsTableViewController(withTitle: title), title: title, iconName: "house")
    }
    
    private func createFavoritesScreen() -> UINavigationController {
        let title = "Favorites"
        return embedInNavigation(viewController: crateItemsTableViewController(withTitle: title, filterFavorites: true), title: title, iconName: "star")
    }
    
    private func crateItemsTableViewController(withTitle title: String, filterFavorites: Bool = false) -> UITableViewController {
        let vc = ItemsTableViewController(itemsVM: ItemsViewModel(), filteredItemsVM: ItemsViewModel())
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.title = title
        
        if !filterFavorites {
            vc.service = MovieAPIItemServiceAdapter(
                api: MovieAPI(),
                select: { [weak vc] item in
                    vc?.select(item: item)
                })
        }
        return vc
    }
    
    private func embedInNavigation(viewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.tabBarItem.image = UIImage(systemName: iconName, withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        navVC.tabBarItem.title = title
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }

}
