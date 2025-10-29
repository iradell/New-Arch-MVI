//
//  ViewHelper.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

extension View {
    func withNavigation<Navigation: Navigator, Resolver: DestinationResolver>(
        navigator: Navigation,
        resolver: Resolver
    ) -> some View where Navigation.Destination == Resolver.Destination {
        NavigationContainer(
            resolver: resolver,
            navigator: navigator
        ) {
            self
        }
    }
}
