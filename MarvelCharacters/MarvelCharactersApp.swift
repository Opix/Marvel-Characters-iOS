//
//  MarvelCharactersApp.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import SwiftUI

@main
struct MarvelCharactersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
