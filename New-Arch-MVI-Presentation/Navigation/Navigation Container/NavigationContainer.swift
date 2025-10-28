//
//  NavigationContainer.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI
internal import FactoryKit

struct NavigationContainer<Resolver: DestinationResolver, Content: View>: View {
    @InjectedObservable(\.router) private var router
    let resolver: Resolver
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Resolver.Destination.self) { destination in
                    resolver.view(for: destination)
                }
                .sheet(item: $router.presentedSheet) { destination in
                    resolver.view(for: destination)
                }
                .fullScreenCover(item: $router.presentedFullScreen) { destination in
                    //resolver.view(for: destination)
                }
        }
    }
}
