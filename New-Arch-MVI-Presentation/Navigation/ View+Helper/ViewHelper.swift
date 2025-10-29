//
//  ViewHelper.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

extension View {
    func withNavigation(navigation: any Navigator, using resolver: any DestinationResolver) -> some View {
        NavigationContainer(
            resolver: AppDestinationResolver(),
            navigator: DefaultNavigator<AppDestination>()
        ) {
            self
        }
    }
}
