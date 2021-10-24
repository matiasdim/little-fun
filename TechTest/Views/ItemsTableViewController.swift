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
    var itemsVM: ItemsViewModel
    var service: ItemService?
    var currentPage: Int = 1
    var isFetchingData: Bool = false
    var activityIndicator: ActivityIndicator?
    
    private var reuseIdentifier = "reuseIdentifier"
    
    init(itemsVM: ItemsViewModel, service: ItemService?) {
        self.itemsVM = itemsVM
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SubtitledTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
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
        return itemsVM.numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SubtitledTableViewCell ?? SubtitledTableViewCell()
                
        cell.configure(item: itemsVM.items[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemsVM.items[indexPath.row]
        item.select()
    }
    
    // MARK: - Scrollview delegate methods
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView &&
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height
            && !isFetchingData
        {
            print("")
        }
    }
    
    // MARK: - Private
    private func fetchItems() {
        if Reachability().isConnected() {
            showActivityIndicator()
            service?.pull(withPage: currentPage, completion: { [weak self] result in
                DispatchQueue.main.async {
                    self?.removeActivityIndicator()
                    switch result {
                        case .success(let itemsVM):
                            self?.itemsVM = itemsVM
                            self?.tableView.reloadData()
                        case .failure(let error):
                            self?.showAlert(title: "Something went Wrong", message: error.localizedDescription, style: .alert, action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    }
                }
            })
        } else {
            showAlert(title: "No internet connection!", message: "Connect to the internet and try again.", style: .alert, action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
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
}

class SubtitledTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(item: ItemViewModel) {
        textLabel?.text = item.title
        detailTextLabel?.text = "\(item.rating)"
        imageView?.image = UIImage(systemName: item.isFavorite ? "star.fill" : "star")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
