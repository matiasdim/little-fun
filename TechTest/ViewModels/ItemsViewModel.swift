//
//  ItemsViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import Foundation

struct ItemsViewModel {
    var items: [ItemViewModel] = []
    
    /// Could be improved to manage automatic numbers of sections and rows of section
    var numberOfRows: Int {
        return items.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    
    
}
