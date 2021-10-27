//
//  ItemsTableViewController.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    
    /// More general types of items and service to decouple the view controller of these and have it more general.
    /// This is a good architecture to have decouples View controllers. This only deals with UI things. (Single responsibility principle)
    var itemsVM: ItemsViewModel!
    var filteredItemsVM: ItemsViewModel!
    var currentPage: Int = 1
    var isFetchingData: Bool = false
    var activityIndicator: ActivityIndicator?
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Items by title"
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchItems()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemsVM.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredItemsVM.numberOfRows
        }
        return itemsVM.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CustomTableCell
        let item = isFiltering ? filteredItemsVM.items[indexPath.row] : itemsVM.items[indexPath.row]
        cell.itemVM = item
        cell.toggleFavorite = { [weak self] item in
            self?.toggleFavorite(item: item)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemsVM.items[indexPath.row]
        item.select(item)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Scrollview delegate methods
    /// To fetch more items when reaching out the bottom of the table
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !isFiltering &&
            scrollView == tableView &&
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height
            && !isFetchingData
        {
            currentPage += 1
            fetchItems()
        }
    }
    
    func select(item: ItemViewModel) {
        let detailVC = ItemDetailViewController(itemVM: item)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        detailVC.title = item.title
        show(detailVC, sender: nil)
    }
    
    // MARK: - Private
    private func fetchItems() {
        /// If no service provided means this VC will populate local persisted favorite movies
        if itemsVM.lookForFavorites {
            itemsVM.fetchFavorites()
            tableView.reloadData()
        } else {
            if !Reachability().isConnected() {
                showAlert(title: "No internet connection!", message: "Connect to the internet and try again.", style: .alert, action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return
            }
            showActivityIndicator()
            isFetchingData = true
            itemsVM.fetchFromServer(withPage: currentPage) { [weak self] result in
                self?.isFetchingData = false
                DispatchQueue.main.async {
                    self?.removeActivityIndicator()
                    switch result {
                        case .success(let items):
                            self?.itemsVM.items.append(contentsOf: items)
                            self?.tableView.reloadData()
                        case .failure(let error):
                            self?.showAlert(title: "Something went Wrong", message: error.localizedDescription, style: .alert, action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    }
                }
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator = ActivityIndicator()
        if let activityIndicator = activityIndicator {
            addChild(activityIndicator)
            activityIndicator.view.frame = view.frame
            view.addSubview(activityIndicator.view)
            activityIndicator.didMove(toParent: self)
        }
    }
    
    private func removeActivityIndicator() {
        activityIndicator?.willMove(toParent: nil)
        activityIndicator?.view.removeFromSuperview()
        activityIndicator?.removeFromParent()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredItemsVM.items = itemsVM.items.filter { (item: ItemViewModel) -> Bool in
            return item.title.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    private func toggleFavorite(item: ItemViewModel) {
        itemsVM.toggleFavorite(item: item)
        if isFiltering{
            filteredItemsVM.toggleFavorite(item: item)
        }
        tableView.reloadData()
    }
}

extension ItemsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let text = searchBar.text {
            filterContentForSearchText(text)
        }
    }
}
