//
//  ApiItem.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation

public struct ApiItem: Decodable {
    let resourceURI: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
        case resourceURI
    }
}
