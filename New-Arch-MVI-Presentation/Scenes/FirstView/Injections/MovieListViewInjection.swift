//
//  FirstViewInjection.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

internal import FactoryKit

extension Container {
    var router: Factory<MovieListViewRouter> { self { DefaultMovieListViewRouter() } }
    var factory: Factory<MovieListViewFactory> { self { DefaultMovieListViewFactory() } }
}
