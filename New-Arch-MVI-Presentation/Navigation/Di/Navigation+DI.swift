//
//  Navigation+DI.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

internal import FactoryKit

extension Container {
    var router: Factory<Router<AppDestination>> { self { Router<AppDestination>() }.singleton }
    var resolver: Factory<AppDestinationResolver> { self { AppDestinationResolver() }.singleton }
}
