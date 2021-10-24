//
//  ItemViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation

struct ItemViewModel {
    var title: String
    var rating: Double
    var overview: String
    var isFavorite: Bool
    
    var select: () -> ()
}

/// Abstraction to decouple ItemViewModel from Movie
extension ItemViewModel {
    init(movie: Movie, selection: @escaping () -> ()) {
        title = movie.title
        rating = movie.rating
        overview = movie.overview
        isFavorite = movie.isFavorite
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


