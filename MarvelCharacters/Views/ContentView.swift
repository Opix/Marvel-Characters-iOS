//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ActionView(viewModel: viewModel)
                    .padding(.bottom, kHalfPadding)
                    .configureNavigationBar {
                        // Clear background color.  Plus the border at the bottom of navigation.
                        $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
                        $0.navigationBar.shadowImage = UIImage()
                    }
                    
                CharacterListView(viewModel: viewModel)
                    .onTapGesture {
                        self.hideKeyboard()
                    }.onAppear {
                        viewModel.fetchCharacters()
                    }
            }.navigationBarTitle(Text("Marvel Characters (\(viewModel.counter))"), displayMode: .inline)
        }
    }
}
