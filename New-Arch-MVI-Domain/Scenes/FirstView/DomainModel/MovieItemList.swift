//
//  MovieItemList.swift
//  New-Arch-MVI-Domain
//
//  Created by Tornike Bardadze on 25.10.25.
//

import Foundation

public struct MovieItemList {
    public let movies: [MovieItem]
    
    public init(
        movies: [MovieItem]
    ) {
        self.movies = movies
    }
}

public struct MovieItem: Identifiable {
    public let id: UUID
    public let url: String
    public let title: String
    public let description: String
    
    public init(
        id: UUID,
        url: String,
        title: String,
        description: String
    ) {
        self.id = id
        self.url = url
        self.title = title
        self.description = description
    }
}
