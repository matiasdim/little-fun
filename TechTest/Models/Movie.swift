//
//  Movie.swift
//  TechTest
//
//  Created by Matías  Gil Echavarría on 23/10/21.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    var rating: Double
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case rating = "vote_average"
    }
}

struct Response: Codable {
    let results: [Movie]
}
