//
//  DatabaseManager.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import Foundation
import SwiftUI
import CoreData

class DatabaseManager {
    private let persistenceController = PersistenceController.shared
    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = persistenceController.container.viewContext
    }
    
    func fetchFavorites() -> [Favorites]? {
        let request : NSFetchRequest<Favorites> = Favorites.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Fetch failed: Error \(error.localizedDescription)")
            return nil
        }
    }

    func getCharacterModels() -> [CharacterModel] {
        guard let fetched = fetchFavorites() else {
            return []
        }

        return fetched.map { $0.toCharacterModel() }
    }
    
    func addFavorite(character: CharacterModel) {
        withAnimation {
            do {
                if let favorites = fetchFavorites(),
                    let _ = favorites.first(where: { $0.id == String(character.id) }) {
                    return
                }
                
                let newFavorite = Favorites(context: viewContext)
                newFavorite.id = String(character.id)
                newFavorite.notes = character.description
                newFavorite.thumbnailUrl = character.thumbnail
                newFavorite.imageUrl = character.largeImage
                newFavorite.name = character.name
                
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func deleteFavorite(characterId: Int) {
        withAnimation {
            guard let favorites = fetchFavorites(),
                  let delete = favorites.first(where: { $0.id == String(characterId) }) else {
                return
            }
            
            do {
                viewContext.delete(delete)
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
