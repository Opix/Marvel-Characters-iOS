//
//  SortOptions.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation
import SwiftUI

enum SortOptions: Int, CaseIterable, Identifiable {
    var id: Int { self.rawValue }
    
    case nameAToZ
    case nameZtoA
    case comicNameAToZ
    case comicNameZToA

    var title: String {
        switch self {
            case .nameAToZ:
                return "Character Name A to Z"
            case .nameZtoA:
                return "Character Name Z to A"
            case .comicNameAToZ:
                return "Comic Name A to Z"
            case .comicNameZToA:
                return "Comic Name Z to A"
        }
    }
}
