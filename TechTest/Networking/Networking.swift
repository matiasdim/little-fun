//
//  Networking.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation
import SystemConfiguration

protocol ItemService {
    func pull(withPage page: Int, completion: @escaping (Result<[ItemViewModel], Error>) -> Void)
}
 
class Reachability {
    func isConnected() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

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

struct MovieAPIItemServiceAdapter: ItemService {
    var api: MovieAPI
    /// let select: () -> () ????
    
    func pull(withPage page: Int, completion: @escaping (Result<[ItemViewModel], Error>) -> Void) {
        api.loadTopRatedMovies(withPage: page) { result in
            switch result {
                case .success(let data):
                    do {
                        let responseArray = try JSONDecoder().decode(Response.self, from: data)
                        var items = [ItemViewModel] ()
                        /// Mapping from Movies array to ItemViewModel could be improved
                        responseArray.results.forEach { movie in
                            items.append(ItemViewModel(movie: movie, selection: {})) /// Work on Selection function!
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
