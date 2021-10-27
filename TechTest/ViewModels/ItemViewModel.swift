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
    
    var select: (ItemViewModel) -> Void
    
    /// For fast coding purposes it just sets an array of dicionaries with the movie info and stores it in user defaults with movie id as key
    /// This should be better handled storing the Object encoding and decoding it into user defaults or even better using  another data persistance solution
    func handleIsFavorite() {
        if !isFavorite {
            do {
                if let data = UserDefaults.standard.object(forKey: "movies") as? Data {
                    do {
                        var movies = try JSONDecoder().decode([Movie].self, from: data)
                        movies.append(Movie(id: id, title: title, rating: rating, overview: overview))
                        let data = try JSONEncoder().encode(movies)
                        UserDefaults.standard.setValue(data, forKey: "movies")
                    } catch {
                        print("")
                    }
                } else {
                    do {
                       
                        let movies = [Movie(id: id, title: title, rating: rating, overview: overview)]
                        let data = try JSONEncoder().encode(movies)
                        UserDefaults.standard.setValue(data, forKey: "movies")
                    } catch {
                        print("")
                    }
                }
               
            } catch {
                print("")
            }
            
//            let itemArray = [["title": title],
//                             ["rating": "\(rating)"],
//                             ["overview": overview]]
//            UserDefaults.standard.setValue(itemArray, forKey: "\(id)")
        } else {
//            UserDefaults.standard.removeObject(forKey: "\(id)")
            if let data = UserDefaults.standard.object(forKey: "movies") as? Data {
                do {
                    var movies = try JSONDecoder().decode([Movie].self, from: data)
                    movies.removeAll(where: { movie in
                        movie.id == self.id
                    })
                    let data = try? JSONEncoder().encode(movies)
                    UserDefaults.standard.setValue(data, forKey: "movies")
                } catch {
                    print("")
                }
            }
        }
    }
    
    func checkIfFavorite() -> Bool {
//        return (UserDefaults.standard.object(forKey: "\(id)")) != nil
        if let data = UserDefaults.standard.object(forKey: "movies") as? Data {
            do {
                var movies = try JSONDecoder().decode([Movie].self, from: data)
                return movies.contains { movie in
                    movie.id == self.id
                }
            } catch {
                print("")
                return false
            }
        }
        return false
    }
}

/// Abstraction to decouple ItemViewModel from Movie
extension ItemViewModel {
    init(movie: Movie, selection: @escaping (ItemViewModel) -> Void) {
        id = movie.id
        title = movie.title
        rating = movie.rating
        overview = movie.overview
        select = selection
    }
}


