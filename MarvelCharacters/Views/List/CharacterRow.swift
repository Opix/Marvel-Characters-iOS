//
//  CharacterRow.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterRow: View {
    @ObservedObject var viewModel: CharacterViewModel
    @State private var showDetails = false

    var body: some View {
        HStack (alignment: .center) {
            if let url = viewModel.thumbnail {
                WebImageView(width: CGFloat(60), height: CGFloat(60), url: url)
            } else {
                Image("character")
                    .frame(width: 60, height: 60, alignment: .center)
                    .padding(.leading, kHalfPadding)
            }
            VStack (alignment: .leading, spacing: 2) {
                HStack (alignment: .center) {
                    Text(viewModel.name)
                        .font(.title3)
                        .bold()
                        .foregroundColor(appDarkGray)
                        .lineLimit(1)
                    
                    Spacer()

                    Button (action: {
                        viewModel.onFavoriteTapped()
                        }) {
                            viewModel.favoriteImage
                    }.buttonStyle(PlainButtonStyle())
                }

                HStack (alignment: .center) {
                    Image("book")
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray2))
                    Text(viewModel.firstComic)
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.systemGray2))
                        .lineLimit(1)
                }
                
                HStack (alignment: .center) {
                    Image("description")
                        .frame(width: 18, height: 18, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray2))
                    Text(viewModel.description)
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.systemGray2))
                        .lineLimit(1)
                }
            }
        }.padding(kHalfPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .overlay(RoundedRectangle(cornerRadius: kCornerRadius / 2).stroke(Color(UIColor.systemGray4), lineWidth: kBorderLineWidth))
        .padding(.horizontal, kDefaultPadding)
        .padding(.vertical, kHalfPadding)// Yes, another padding.  This will keep the borderline away from the edges.  The first one is to keep contents of row away from the border.
    }
}
