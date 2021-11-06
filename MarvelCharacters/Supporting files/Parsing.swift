//
//  Parsing.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MarvelError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
        .parsing(description: error.localizedDescription)
    }.eraseToAnyPublisher()
}
