//
//  MovieListViewRouter.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

internal import FactoryKit

public protocol MovieListViewRouter: AnyObject {
    func navigateToMovieDetails(withId: String)
}


public class DefaultMovieListViewRouter: MovieListViewRouter {
    
    @Injected(\.navigator) private var navigator
    
    public func navigateToMovieDetails(withId: String) {
        navigator.navigate(to: .movieDetials)
    }
    
}
