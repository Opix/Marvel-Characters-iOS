//
//  CharacterViewModel.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import Foundation
import SwiftUI

class CharacterViewModel: ObservableObject, Identifiable {
    @Published var character: CharacterModel
    private let databaseManager = DatabaseManager()
    
    init(character: CharacterModel) {
        self.character = character
    }
    
    var id: Int {
        return character.id
    }
    
    var name: String {
        return character.name
    }

    var description: String {
        if character.description.isEmpty {
            return "N/A"
        }
        return character.description
    }

    var thumbnail: String {
        return character.thumbnail
    }
    
    var largeImage: String {
        return character.largeImage
    }
    
    func onFavoriteTapped() {
        character.favorite.toggle()
        
        if character.favorite {
            databaseManager.addFavorite(character: character)
        } else {
            databaseManager.deleteFavorite(characterId: character.id)
        }
    }
    
    var firstComic: String {
        if character.firstComic.isEmpty {
            return "N/A"
        }
        return character.firstComic
    }
}

extension CharacterViewModel {
    var favoriteImage: some View {
        if character.favorite {
            return Image("favorite").foregroundColor(appFavroiteColor)
        } else {
            return Image("non_favorite").foregroundColor(Color(UIColor.systemGray4))
        }
    }
    
    var isFavorite: Bool {
        return character.favorite
    }
}
