//
//  CharacterDetailsView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailsView: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        ScrollView (.vertical) {
            Section {
                Text(viewModel.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(appDarkGray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, kDefaultPadding)
            
            Section {
                WebImage(url: URL(string: viewModel.largeImage))
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                    .placeholder(Image("character")) // Placeholder Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFit()
                    .frame(width: 300, height: 200, alignment: .center)
            }
            
            Section {
                Button (action: {
                    viewModel.onFavoriteTapped()
                    }) {
                        viewModel.favoriteImage
                }.buttonStyle(PlainButtonStyle())
            }
            
            Section {
                Text("Description")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(kHalfPadding)
                    .background(Color(UIColor.systemGray5))

                Text(viewModel.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, kHalfPadding)
            }.padding(.horizontal, kDefaultPadding)
            
            SectionListView(title: "Comics", list: viewModel.character.comics)
            SectionListView(title: "Stories", list: viewModel.character.stories)
            SectionListView(title: "Events", list: viewModel.character.events)
            SectionListView(title: "Series", list: viewModel.character.series)

        }.padding(.bottom, kDefaultPadding)
    }
}
