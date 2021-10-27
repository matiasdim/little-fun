//
//  MovieAPIItemServiceAdapter.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 26/10/21.
//

import Foundation

struct MovieAPIItemServiceAdapter: ItemService {
    
    let api: MovieAPI
    let select: (ItemViewModel) -> ()
    
    func pull(withPage page: Int, completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        api.loadTopRatedMovies(withPage: page) { result in
            switch result {
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data)
                        var items = [ItemViewModel]()
                        for movie in response.results {
                            items.append(ItemViewModel(movie: movie, persistanceHandler: PersistanceDataHandler(), selection: select))
                        }
                        completion(.success(items))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
