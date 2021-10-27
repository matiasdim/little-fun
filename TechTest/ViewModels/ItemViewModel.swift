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
    
    /// Computed property that checks into User defaults if the item has been stored as favorite
    var isFavorite: Bool {
        return checkIfFavorite()
    }
    
    var persistanceHandler: PersistanceDataHandler
    var select: (ItemViewModel) -> Void
    
}

/// Abstraction to decouple base ItemViewModel from Movie
extension ItemViewModel {
    
    init(movie: Movie, persistanceHandler: PersistanceDataHandler, selection: @escaping (ItemViewModel) -> Void) {
        id = movie.id
        title = movie.title
        rating = movie.rating
        overview = movie.overview
        select = selection
        self.persistanceHandler = persistanceHandler
    }
    
    /// persitance made in User defaults to speed up the proces of creating the Favorits functionality
    func handleIsFavorite() {
        if !isFavorite {        
            if let data = persistanceHandler.getObject(forKey: Movie.storingKey) {
                if var movies = decodeMovies(fromData: data) {
                    movies.append(Movie(id: id, title: title, rating: rating, overview: overview))
                    if let data = encode(movies: movies) {
                        persistanceHandler.set(data: data, forKey: Movie.storingKey)
                    }
                }
            } else {
                /// Logic for when it is first movie that is being persisted
                let movies = [Movie(id: id, title: title, rating: rating, overview: overview)]
                if let data = encode(movies: movies) {
                    persistanceHandler.set(data: data, forKey: Movie.storingKey)
                }
            }
        } else {
            if let data = persistanceHandler.getObject(forKey: Movie.storingKey), var movies = decodeMovies(fromData: data) {
                    movies.removeAll(where: { movie in
                        movie.id == self.id
                    })
                    if let updatedData = encode(movies: movies) {
                        persistanceHandler.set(data: updatedData, forKey: Movie.storingKey)
                    }
            }
        }
    }
    
    func checkIfFavorite() -> Bool {
        if let data = persistanceHandler.getObject(forKey: Movie.storingKey), let movies = decodeMovies(fromData: data) {
            return movies.contains { movie in
                movie.id == self.id
            }
        }
        return false
    }
    
    // MARK: - private
    
    private func decodeMovies(fromData data: Data) -> [Movie]? {
        do {
            return try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            return nil
        }
    }
    
    private func encode(movies: [Movie]) -> Data? {
        do {
            return try JSONEncoder().encode(movies)
        } catch {
            return nil
        }
    }
}


