//
//  Double+ext.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/27/21.
//  Copyright © 2021 Opix. All rights reserved.
//

import Foundation

extension Double {
    var formatTo1Fraction: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1

        return formatter.string(from: NSNumber(value: self)) ?? "0.0"
    }
}
