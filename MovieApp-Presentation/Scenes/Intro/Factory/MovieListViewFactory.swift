//
//  MovieListViewFactory.swift
//  MovieApp-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

internal import New_Arch_MVI_PresentationCore

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
