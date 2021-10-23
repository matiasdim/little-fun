//
//  ItemViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation

struct ItemViewModel {
    let title: String
    let subtitle: String
    
    var select: () -> ()
}

/// Abstraction to decouple ItemViewModel from Movie
extension ItemViewModel {
    init(movie: Movie, selection: @escaping () -> ()) {
        title = movie.title
        subtitle = movie.duration
        select = selection
    }
    
}

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


