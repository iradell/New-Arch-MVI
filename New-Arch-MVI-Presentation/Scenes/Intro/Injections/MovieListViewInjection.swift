//
//  FirstViewInjection.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

internal import FactoryKit

extension Container {
    var movieListRouter: Factory<MovieListViewRouter> { self { DefaultMovieListViewRouter() } }
    var movieListFactory: Factory<DefaultMovieListViewFactory> { self { DefaultMovieListViewFactory() } }
}
