//
//  ApiData.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation

public struct ApiData: Decodable {
    let results: [ApiCharacter]
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case total
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try values.decode([ApiCharacter].self, forKey: .results)
        self.total = try values.decode(Int.self, forKey: .total)
    }
}
