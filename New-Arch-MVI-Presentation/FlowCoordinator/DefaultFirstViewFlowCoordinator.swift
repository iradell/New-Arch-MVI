//
//  DefaultFirstViewFlowCoordinator.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import New_Arch_MVI_Api
import SwiftUI
internal import FactoryKit
internal import New_Arch_MVI_PresentationCore

public class DefaultFirstViewFlowCoordinator: FirstViewFlowCoordinator {
    
    @Injected(\.navigator) private var navigator
    @Injected(\.resolver) private var resolver
    @Injected(\.factory) private var factory
    
    public init() { }
    
    @MainActor
    public func firstView() -> some View {
        factory
            .make(parameters: .init())
            .withNavigation(
                navigator: navigator,
                resolver: resolver
            )
    }
}
