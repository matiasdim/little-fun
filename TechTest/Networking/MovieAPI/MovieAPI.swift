//
//  MovieAPI.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

import Foundation

struct MovieAPI {
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let APIKey = "55957fcf3ba81b137f8fc01ac5a31fb5"
    let session = URLSession(configuration: .default)
    
    func loadTopRatedMovies(withPage page: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: "\(baseURL)top_rated?page=\(page)&api_key=\(APIKey)") {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                if let _ = response, let data = data {
                    completion(.success(data))
                }
            })
            
            task.resume()
        } else {
            /// handle error
        }
    }
    
}
