//
//  ApiThumbnail.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation
import SwiftUI

public struct ApiThumbnail: Codable {
    var path: String
    var ext: String
    
    init(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    var thumbnailUrl: String {
        return "\(path)/\(thumbnailKey).\(ext)".replacingOccurrences(of: "http", with: "https")
    }
    
    var largeImageUrl: String {
        return "\(path)/\(largeImageKey).\(ext)".replacingOccurrences(of: "http", with: "https")
    }
}
