//
//  ApiSummary.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation

public struct ApiSummary: Decodable {
    let items: [ApiItem]?
    let available: Int
    let collectionURI: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case available
        case collectionURI
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try values.decode([ApiItem].self, forKey: .items)
        self.available = try values.decode(Int.self, forKey: .available)
        self.collectionURI = try values.decode(String.self, forKey: .collectionURI)
    }
}
