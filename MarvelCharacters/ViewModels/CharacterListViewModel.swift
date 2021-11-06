//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/23/21.
//

import SwiftUI
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var dataSource: [CharacterViewModel] = []
    var originalDataSource: [CharacterViewModel] = []
    
    @Published var currentSort: SortOptions = .nameAToZ
    @Published var currentFilter: FilterOptions = .all
    @Published var searchText: String = ""
    @Published var errorMessage: String? = nil

    private let marvelFetcher: MarvelFetchable
    private var disposables = Set<AnyCancellable>()
    var totalCharacters = 0
    private var offset = 0
    
    private let databaseManager = DatabaseManager()
    private let favorites: [CharacterModel]
    
    init(marvelFetcher: MarvelFetchable) {
        self.marvelFetcher = marvelFetcher
        self.favorites = databaseManager.getCharacterModels()
    }
    
    func fetchCharacters() {
        marvelFetcher.fetchCharacters(offset: self.offset)
        .map { response in
            CharacterData(viewModels: response.data.results.map { character in
                CharacterViewModel(character: character.toModel(isFavorite: self.favorites.first(where: { character.id == $0.id}) != nil))
            }, total: response.data.total)
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
        
            switch value {
                case .failure(let error):
                    self.originalDataSource = self.favorites.map { CharacterViewModel(character: $0) }
                    self.dataSource = self.originalDataSource
                    print("Failed 😫: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                
                case .finished:
                    self.errorMessage = nil
                    break
            }
        },
        receiveValue: { [weak self] download in
            guard let self = self else { return }

            self.originalDataSource.append(contentsOf: download.viewModels)
            self.totalCharacters = download.total
            self.offset += kMaxDownload
            self.dataSource = self.originalDataSource
        })
        .store(in: &disposables)
    }
}

extension CharacterListViewModel {
    func filter(by option: FilterOptions) {
        if self.currentFilter == option {
            return
        }
        self.currentFilter = option
        
        if currentFilter == .favoritesOnly {
            dataSource = originalDataSource.filter { $0.character.favorite }
        } else {
            dataSource = originalDataSource
        }
    }
    
    func search() {
        self.searchText = self.searchText.trimmingCharacters(in: .whitespaces)
        guard !self.searchText.isEmpty else {
            return
        }
        let uppercased = searchText.uppercased()
        dataSource = originalDataSource.filter ({ $0.character.name.uppercased().contains(uppercased) || $0.character.firstComic.uppercased().contains(uppercased) })
    }
    
    func clearSearch() {
        searchText = ""
        dataSource = originalDataSource
    }
    
    func sort(by option: SortOptions) {
        if self.currentSort == option {
            return
        }
        
        self.currentSort = option
        
        switch option {
            case .comicNameAToZ:
                self.dataSource.sort(by: { $0.firstComic < $1.firstComic })
            case .comicNameZToA:
                self.dataSource.sort(by: { $0.firstComic > $1.firstComic })
            case .nameAToZ:
                self.dataSource.sort(by: { $0.name < $1.name })
            case .nameZtoA:
                self.dataSource.sort(by: { $0.name > $1.name })
        }
    }
    
    var hasData: Bool {
        return dataSource.count > 0
    }
    
    func clearErrorMessage() {
        errorMessage = nil
    }

    var counter: String {
        return String(dataSource.count)
    }
    
    public var isFull: Bool {
        return dataSource.count >= totalCharacters
    }
}
