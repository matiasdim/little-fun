//
//  ItemViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation
import UIKit

struct ItemViewModel {
    var title: String
    var rating: Double
    var overview: String
    var isFavorite: Bool
    
    var select: ((_ navigationController: UINavigationController, _ itemVM: ItemViewModel) -> ())?
}

/// Abstraction to decouple ItemViewModel from Movie
extension ItemViewModel {
    init(movie: Movie, selection: ((_ navigationController: UINavigationController, _ itemVM: ItemViewModel) -> ())?) {
        title = movie.title
        rating = movie.rating
        overview = movie.overview
        isFavorite = movie.isFavorite
        select = selection
    }
    
}


