//
//  Navigation+DI.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

internal import FactoryKit
internal import New_Arch_MVI_Navigation


extension Container {
    var navigator: Factory<DefaultNavigator<AppDestination>> { self { DefaultNavigator<AppDestination>() }.singleton }
    var resolver: Factory<AppDestinationResolver> { self { AppDestinationResolver() }.singleton }
}
