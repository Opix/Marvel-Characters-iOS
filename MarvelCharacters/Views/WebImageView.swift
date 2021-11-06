//
//  WebImageView.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/28/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    private var width: CGFloat = 60.0
    private var height: CGFloat = 60.0
    private var url: String = ""
    
    init(width: CGFloat, height: CGFloat, url: String) {
        self.width = width
        self.height = height
        self.url = url
    }
    
    var body: some View {
        WebImage(url: URL(string: url))
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
            .frame(width: width, height: height, alignment: .center)
    }
}

struct WebImageView_Previews: PreviewProvider {
    static var previews: some View {
        WebImageView(width: 60, height: 60, url: "String")
    }
}
