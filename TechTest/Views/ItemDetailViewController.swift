//
//  ItemDetailViewController.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var itemVM: ItemViewModel
    
    init(itemVM: ItemViewModel) {
        self.itemVM =  itemVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
