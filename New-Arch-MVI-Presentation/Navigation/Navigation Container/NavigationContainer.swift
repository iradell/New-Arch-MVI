//
//  NavigationContainer.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI
internal import FactoryKit

struct NavigationContainer<Resolver: DestinationResolver, Navigation: Navigator, Content: View>: View
where Navigation.Destination == Resolver.Destination {

    let resolver: Resolver
    @State var navigator: Navigation

    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $navigator.path) {
            content()
                .navigationDestination(for: Resolver.Destination.self) { destination in
                    resolver.view(for: destination)
                }
                .sheet(item: $navigator.presentedSheet) { destination in
                    resolver.view(for: destination)
                }
                .fullScreenCover(item: $navigator.presentedFullScreen) { destination in
                    resolver.view(for: destination)
                }
        }
    }
}
