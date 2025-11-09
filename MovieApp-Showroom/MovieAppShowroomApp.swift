//
//  MovieAppShowroomApp.swift
//  MovieApp-Showroom
//
//  Created by Tornike Bardadze on 23.10.25.
//

import SwiftUI
import MovieApp_Api
import MovieApp_Presentation
import FactoryKit

@main
struct MovieAppShowroomApp: App {
    @Injected(\.factory) private var factory
    var body: some Scene {
        WindowGroup {
            factory.firstView()
        }
    }
}

extension Container {
    var factory: Factory<DefaultFirstViewFlowCoordinator> {
        self { @MainActor in
            DefaultFirstViewFlowCoordinator()
        }
    }
}
