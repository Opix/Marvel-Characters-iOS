//
//  MarvelError.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import Foundation

enum MarvelError: Error {
    case parsing(description: String)
    case network(description: String)
}
