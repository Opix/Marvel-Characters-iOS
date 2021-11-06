//
//  SectionListView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import SwiftUI

struct SectionListView: View {
    let title: String
    let list: [String]
    
    init(title: String, list: [String]) {
        self.title = title
        self.list = list
    }
    
    var body: some View {
        Section {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(kHalfPadding)
                .background(Color(UIColor.systemGray5))

            if list.count > 0 {
                ForEach(list.indices) { i in
                    Text("🔹 " + list[i])
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, kHalfPadding)
                        .padding(.vertical, kQuaterPadding)
                }
            } else {
                Text("N/A")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, kHalfPadding)
            }
        }.padding(.horizontal, kDefaultPadding)
    }
}
