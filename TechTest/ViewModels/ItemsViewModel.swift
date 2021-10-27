//
//  ItemsViewModel.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import Foundation

struct ItemsViewModel {
    var items: [ItemViewModel] = []
    let persistanceDataHandler: PersistanceDataHandler
    var service: ItemService?
    
    /// Could be improved to manage automatic numbers of sections and rows of section
    var numberOfRows: Int {
        return items.count
    }
    
    var numberOfSections: Int {
        return 1
    }
    var lookForFavorites = false
}

extension ItemsViewModel {
    mutating func fetchFavorites() {
        if let data = persistanceDataHandler.getObject(forKey: Movie.storingKey), let movies = decodeMovies(fromData: data) {
            items.removeAll()
            for movie in movies {
                items.append(ItemViewModel(movie: movie, persistanceHandler: PersistanceDataHandler(), selection: {_ in }))
            }
        }
    }
    
    func fetchFromServer(withPage page: Int, completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        service?.pull(withPage: page, completion: completion)
    }
    
    func toggleFavorite(item: ItemViewModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].handleIsFavorite()
        }
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
