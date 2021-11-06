//
//  Constants.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation
import SwiftUI

let apiPublicKey        = "MARVEL_PUBLIC_KEY"
let apiPrivateKey       = "MARVEL_PRIVATE_KEY"
let apiHostKey          = "MARVEL_HOST_KEY"
let marvelScheme        = "https"
let marvelCharacterPath = "characters"

// Reference: https://developer.marvel.com/documentation/images
let thumbnailKey = "standard_small" // 65 x 45px
let largeImageKey = "landscape_large" // 190 x 140px

let kCornerRadius: CGFloat              = 16
let kDefaultPadding: CGFloat            = 16
let kHalfPadding: CGFloat               = 8
let kQuaterPadding: CGFloat             = 4
let kBorderLineWidth: CGFloat           = 1.25
let kSelectedBorderLineWidth: CGFloat   = 2.5
let kMaxDownload: Int                   = 100


let appPrimaryColor = Color.blue
let appFavroiteColor = Color.red
let appDarkGray     = Color(red: 129 / 255, green: 129 / 255, blue: 129 / 255)
