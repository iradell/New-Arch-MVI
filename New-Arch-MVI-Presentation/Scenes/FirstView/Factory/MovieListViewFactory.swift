//
//  MovieListViewFactory.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import Foundation

// MARK: - MovieListViewFactory
protocol MovieListViewFactory: ViewFactory where
    Parameters == MovieListViewModelParameters,
    View == MovieListView<DefaultMovieListViewModel> {}

// MARK: - DefaultMovieListViewFactory
final class DefaultMovieListViewFactory: MovieListViewFactory {
    
    func make(parameters: MovieListViewModelParameters) -> MovieListView<DefaultMovieListViewModel> {
        let viewModel = DefaultMovieListViewModel(
            parameters: parameters
        )
        return MovieListView(viewModel: viewModel)
    }
    
}


protocol ViewFactory {
    associatedtype Parameters
    associatedtype View
    func make(parameters: Parameters) -> View
}
