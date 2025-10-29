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
internal import New_Arch_MVI_Navigation

public class DefaultFirstViewFlowCoordinator: FirstViewFlowCoordinator {
    
    @Injected(\.navigator) private var navigator
    @Injected(\.resolver) private var resolver
    @Injected(\.movieListFactory) private var firstViewFactory
    
    public init() { }
    
    public func firstView() -> some View {
        firstViewFactory
            .make(parameters: .init())
            .withNavigation(
                navigator: navigator,
                resolver: resolver
            )
    }
}
