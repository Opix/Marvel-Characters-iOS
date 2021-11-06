//
//  Favorites.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation

@objc(Favorites)
open class Favorites: _Favorites {
	// Custom logic goes here.
    
    func toCharacterModel() -> CharacterModel {
        return CharacterModel(Int(id) ?? 0, name: name, description: notes ?? "", thumbnail: thumbnailUrl ?? "", largeImage: imageUrl ?? "", comics: [], stories: [], events: [], series: [], favorite: true)
        
    }
}
