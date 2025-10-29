//
//  New_Arch_MVI_ShowroomApp.swift
//  New-Arch-MVI-Showroom
//
//  Created by Tornike Bardadze on 23.10.25.
//

import SwiftUI
import New_Arch_MVI_Api
import New_Arch_MVI_Presentation
import FactoryKit

@main
struct New_Arch_MVI_ShowroomApp: App {
    @Injected(\.factory) private var factory
    var body: some Scene {
        WindowGroup {
            factory.firstView()
        }
    }
}

extension Container {
    var factory: Factory<DefaultFirstViewFlowCoordinator> { self { DefaultFirstViewFlowCoordinator() } }
}
