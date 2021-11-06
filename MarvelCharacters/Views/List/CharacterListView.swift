//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 8/28/21.
//
// References:
// https://stackoverflow.com/questions/61495141/passing-core-data-fetchedresultst-for-previews-in-swiftui

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    @State private var selectedCharacter: CharacterViewModel? = nil

    var body: some View {
        GeometryReader { geo in
            if viewModel.dataSource.count > 0 {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.dataSource) { characterViewModel in
                            CharacterRow(viewModel: characterViewModel)
                            .frame(width: geo.size.width, alignment: .leading)
                            .contentShape(Rectangle())
                            .simultaneousGesture(TapGesture().onEnded {
                                selectedCharacter = characterViewModel
                            })
                        }
                        
                        if !viewModel.isFull {
                            ProgressView().onAppear {
                                viewModel.fetchCharacters()
                            }.padding(.vertical, kHalfPadding)
                        }
                    }
                    .padding(.top, kHalfPadding)
                    .padding(.bottom, kDefaultPadding)
                    .frame(width: geo.size.width, alignment: .top)
                    .background(Color(UIColor.systemGray6))
                }.sheet(isPresented: .constant(selectedCharacter != nil), onDismiss: {
                    // Clear selection so that when sorting or filter is applied, the sheet will not pop up.
                    selectedCharacter = nil
                }) {
                    if let selected = selectedCharacter {
                        CharacterDetailsView(viewModel: selected)
                    }
                }
            } else {
                VStack {
                    if viewModel.errorMessage != nil {
                        Image("error")
                            .frame(width: 36, height: 36, alignment: .center)
                            .foregroundColor(Color.red)
                    }
                    
                    Text(viewModel.errorMessage ?? "No Results")
                        .padding(kDefaultPadding)
                        .foregroundColor(Color(UIColor.systemGray2))
                }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .background(Color(UIColor.systemGray6))
            }
        }
    }
}
