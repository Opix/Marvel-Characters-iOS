//
//  NavigationConfigurator.swift
//  MarvelCharacters
//
//  Created by Osamu Chiba on 9/26/21.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    let configure: (UINavigationController) -> Void

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) -> NavigationConfigurationViewController {
        NavigationConfigurationViewController(configure: configure)
    }

    func updateUIViewController(
        _ uiViewController: NavigationConfigurationViewController,
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) { }
}

final class NavigationConfigurationViewController: UIViewController {
    let configure: (UINavigationController) -> Void

    init(configure: @escaping (UINavigationController) -> Void) {
        self.configure = configure
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let navigationController = navigationController {
            configure(navigationController)
        }
    }
}
