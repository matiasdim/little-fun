//
//  ItemServiceProtocol.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 25/10/21.
//

protocol ItemService {
    func pull(withPage page: Int, completion: @escaping (Result<[ItemViewModel], Error>) -> Void)
}
