//
//  MovieListViewRouter.swift
//  MovieApp-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

internal import FactoryKit
internal import New_Arch_MVI_Navigation

public protocol MovieListViewRouter: AnyObject {
    func navigateToMovieDetails(with model: DetailsViewModelParameters)
}

public class DefaultMovieListViewRouter: MovieListViewRouter {
    
    @Injected(\.navigator) private var navigator
    
    public func navigateToMovieDetails(with model: DetailsViewModelParameters) {
        navigator.navigate(to: .movieDetials(model))
    }
    
}
