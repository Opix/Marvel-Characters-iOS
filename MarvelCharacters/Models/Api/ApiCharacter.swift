//
//  ApiCharacter.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation
import SwiftUI

public struct ApiCharacter: Decodable {
    var id: Int
    var name: String
    var description: String
    var modified: String
    var resourceURI: String
    var thumbnail: ApiThumbnail
    var comics: ApiSummary
    var stories: ApiSummary
    var events: ApiSummary
    var series: ApiSummary
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case modified
        case resourceURI
        case thumbnail
        case comics
        case stories
        case events
        case series
    }
}

extension ApiCharacter {
    func toModel(isFavorite: Bool = false) -> CharacterModel {
        let flattenedComics = comics.items?.filter { !$0.name.isEmpty }.compactMap { $0.name } ?? [String]()
        let flattenedStories = stories.items?.filter { !$0.name.isEmpty }.compactMap { $0.name } ?? [String]()
        let flattenedEvents = events.items?.filter { !$0.name.isEmpty }.compactMap { $0.name } ?? [String]()
        let flattenedSeries = series.items?.filter { !$0.name.isEmpty }.compactMap { $0.name } ?? [String]()

        return CharacterModel(id,
                name: name,
                description: description,
                thumbnail: thumbnail.thumbnailUrl,
                largeImage: thumbnail.largeImageUrl,
                comics: flattenedComics,
                stories: flattenedStories,
                events: flattenedEvents,
                series: flattenedSeries,
                favorite: isFavorite)
    }
}
