//
//  ItemViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation
import UIKit

struct ItemViewModel {
    var id: Int
    var title: String
    var rating: Double
    var overview: String
    var isFavorite: Bool {
        didSet {
            handleIsFavorite()
        }
    }
    
    var select: (ItemViewModel) -> Void
    
    /// For fast coding purposes it just sets an array of dicionaries with the movie info and stores it in user defaults with movie id as key
    /// This should be better handled storing the Object encoding and decoding it into user defaults or even better using  another data persistance solution
    func handleIsFavorite() {
        if isFavorite {
            let itemArray = [["title": title],
                             ["rating": "\(rating)"],
                             ["overview": overview]]
            UserDefaults.standard.setValue(itemArray, forKey: "\(id)")
        } else {
            UserDefaults.standard.removeObject(forKey: "\(id)")
        }
    }
}

/// Abstraction to decouple ItemViewModel from Movie
extension ItemViewModel {
    init(movie: Movie, selection: @escaping (ItemViewModel) -> Void) {
        id = movie.id
        title = movie.title
        rating = movie.rating
        overview = movie.overview
        isFavorite = movie.isFavorite
        select = selection
    }
    
}


