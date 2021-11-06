//
//  NavigationConfigurationViewModifier.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import SwiftUI

struct NavigationConfigurationViewModifier: ViewModifier {
    let configure: (UINavigationController) -> Void

    func body(content: Content) -> some View {
        content.background(NavigationConfigurator(configure: configure))
    }
}
