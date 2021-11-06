//
//  CharacterModel.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation
import SwiftUI

public struct CharacterModel {
    let id: Int
    let name: String
    let description: String
    let thumbnail: String
    let largeImage: String
    var favorite = false
    let comics: [String]
    let stories: [String]
    let events: [String]
    let series: [String]
    
    init(_ id: Int, name: String, description: String, thumbnail: String, largeImage: String, comics: [String], stories: [String], events: [String], series: [String], favorite: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        self.largeImage = largeImage
        self.comics = comics
        self.stories = stories
        self.events = events
        self.series = series
        self.favorite = favorite
    }
    
    
    var firstComic: String {
        if comics.count > 0 {
            return comics[0]
        }
        return ""
    }
}
