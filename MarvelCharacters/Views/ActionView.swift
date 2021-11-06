//
//  ActionView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/27/21.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject var viewModel: CharacterListViewModel

    @State private var showSortActionSheet: Bool = false
    @State private var showFilterActionSheet: Bool = false

    public init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack (alignment: .center) {
            ZStack {
                TextField("Search for a character", text: $viewModel.searchText,
                    // This is triggered when return key is pressed.
                        onCommit: {
                            viewModel.search()
                            self.hideKeyboard()
                    })
                    .padding(8)
                    .multilineTextAlignment(.leading)
                    .overlay(RoundedRectangle(cornerRadius: kCornerRadius / 2).stroke(Color(UIColor.systemGray4), lineWidth: kBorderLineWidth))
                    .shadow(radius: kCornerRadius)

                // overlay above seems to be covering this button and therefore becomes non-responsive to tapping.  So place this above the text.
                HStack {
                    Spacer()
                    Button (action: {
                            viewModel.clearSearch()
                        }) {
                        Image("clear")
                            .foregroundColor(appPrimaryColor)
                    }
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(kHalfPadding)
                }
            }
            
            Button(action: {
                self.hideKeyboard()
                showFilterActionSheet = true
            }) {
                Image("filter").foregroundColor(appPrimaryColor)
            }
            .frame(width: 40, height: 40, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: kCornerRadius / 2).stroke(Color(UIColor.systemGray4), lineWidth: kBorderLineWidth))
            .shadow(radius: kCornerRadius)
            .actionSheet(isPresented: $showFilterActionSheet) {
                generateFilterActionSheet()
            }.if(viewModel.hasData) { $0.foregroundColor(appPrimaryColor) } else: { $0.foregroundColor(Color(UIColor.systemGray2)) }
            .disabled(!viewModel.hasData)
            
            Button(action: {
                self.hideKeyboard()
                showSortActionSheet = true
            }) {
                Image("sort").foregroundColor(viewModel.hasData ? appPrimaryColor : Color(UIColor.systemGray2))
            }
            .frame(width: 40, height: 40, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: kCornerRadius / 2).stroke(Color(UIColor.systemGray4), lineWidth: kBorderLineWidth))
            .shadow(radius: kCornerRadius)
            // Note: confirmationDialog for iOS 15 or later
            .actionSheet(isPresented: $showSortActionSheet) {
                generateSortActionSheet()
            }.if(viewModel.hasData) { $0.foregroundColor(appPrimaryColor) } else: { $0.foregroundColor(Color(UIColor.systemGray2)) }
            .disabled(!viewModel.hasData)
        }.padding(.horizontal, kDefaultPadding)
    }
    
    private func generateSortActionSheet() -> ActionSheet {
        let buttons = SortOptions.allCases.enumerated().map { i, option in
            Alert.Button.default(viewModel.currentSort == option ? Text("\(option.title) ✔️") : Text(option.title),
                                 action: { viewModel.sort(by: option) } )
        }
        return ActionSheet(title: Text("Sort By"), buttons: buttons + [Alert.Button.cancel()])
    }
    
    private func generateFilterActionSheet() -> ActionSheet {
        let buttons = FilterOptions.allCases.enumerated().map { i, option in
            Alert.Button.default(viewModel.currentFilter == option ? Text("\(option.title) ✔️") : Text(option.title),
                                 action: { viewModel.filter(by: option) } )
        }
        return ActionSheet(title: Text("Filter By"), buttons: buttons + [Alert.Button.cancel()])
    }
}
