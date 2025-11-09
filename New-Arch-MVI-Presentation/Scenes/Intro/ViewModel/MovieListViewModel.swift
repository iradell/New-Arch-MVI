//
//  MovieListViewModel.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import Observation
internal import New_Arch_MVI_Domain
internal import New_Arch_MVI_PresentationCore
internal import FactoryKit
import Foundation

// MARK: - Parameters
public struct MovieListViewModelParameters { }

// MARK: - State
struct MovieListViewModelState {
    var data: ViewModelState<MovieItemList>
}

// MARK: - SideEffect
enum MovieListViewModelSideEffect {
    case navigateToDetailsPage
    case showEditPage
}

// MARK: - Intents
enum MovieListViewModelIntent {
    case didSelectMovie(MovieItem)
    case removeAll
}

protocol MovieListViewModel: ViewModel where
    Parameters == MovieListViewModelParameters,
    State == MovieListViewModelState,
    Intent == MovieListViewModelIntent,
    SideEffect == MovieListViewModelSideEffect { }
    
@Observable
final class DefaultMovieListViewModel: MovieListViewModel {
    
    @ObservationIgnored
    @Injected(\.movieListRouter) private var router
    
    var state: MovieListViewModelState
    
    var onSideEffect: ((MovieListViewModelSideEffect) -> Void)?
    
    init(parameters: MovieListViewModelParameters) {
        state = .init(data: .loading)
    }
    
    func onLoad() {
        state.data = .loading
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            state.data = .success(
                .init(
                    movies: moviesData.map { movie in
                            .init(
                                id: UUID(),
                                url: movie.url,
                                title: movie.title,
                                description: movie.description
                            )
                    }
                )
            )
        }
    }
    
    func handleIntent(_ intent: MovieListViewModelIntent) {
        switch intent {
        case .didSelectMovie(let movie):
            router.navigateToMovieDetails(
                with: .init(
                    image: URL(string: movie.url)!,
                    title: movie.title,
                    description: movie.description
                )
            )
        case .removeAll:
            state.data = .success(.init(movies: []))
        }
    }
    
    let moviesData: [(
        url: String,
        title: String,
        description: String
    )] = [
        (
            "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            "The Dark Knight",
            "Batman faces his greatest psychological and physical challenges when the Joker wreaks havoc on Gotham."
        ),
        (
            "https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg",
            "Avatar",
            "A paraplegic Marine on a mission to Pandora finds himself torn between obeying orders and protecting a new world."
        ),
        (
            "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg",
            "Avengers: Endgame",
            "The Avengers assemble once more in a race to undo Thanos’ devastation and restore balance to the universe."
        ),
        (
            "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg",
            "Iron Man",
            "After escaping captivity, billionaire Tony Stark uses his tech genius to become the armored hero Iron Man."
        ),
        (
            "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
            "Spider-Man: No Way Home",
            "Spider-Man faces multiverse-shattering consequences when his identity is exposed to the world."
        ),
        (
            "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
            "Joker",
            "An isolated comedian descends into madness and becomes the iconic criminal mastermind known as the Joker."
        ),
        (
            "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
            "Titanic",
            "A sweeping love story unfolds aboard the tragic maiden voyage of the RMS Titanic."
        ),
        (
            "https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
            "Dune",
            "A brilliant young man must travel to the most dangerous planet in the universe to secure the future of his people."
        ),
        (
            "https://image.tmdb.org/t/p/w500/wqnLdwVXoBjKibFRR5U3y0aDUhs.jpg",
            "Star Wars: The Force Awakens",
            "A new threat rises as heroes old and new unite in the fight against the First Order."
        ),
        (
            "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
            "The Matrix",
            "A hacker discovers the world he knows is a simulation and joins a rebellion against its creators."
        ),
        (
            "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg",
            "Guardians of the Galaxy Vol. 3",
            "The Guardians must band together to protect one of their own while facing a dangerous new enemy."
        ),
        (
            "https://image.tmdb.org/t/p/w500/drlfSCIlMKrEeMPhi8pqY4xGxj.jpg",
            "Inception",
            "A skilled thief enters people’s dreams to steal secrets, but a final mission could cost everything."
        ),
        (
            "https://image.tmdb.org/t/p/w500/v5CfpzxoJDkZxjZAizClFdlEF0U.jpg",
            "The Social Network",
            "The creation of Facebook sparks innovation, conflict, and legal battles."
        ),
        (
            "https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg",
            "Spirited Away",
            "A young girl becomes trapped in a mysterious spirit world and must find her way home."
        ),
        (
            "https://image.tmdb.org/t/p/w500/7lyBcpYB0Qt8gYhXYaEZUNlNQAv.jpg",
            "Pulp Fiction",
            "Multiple crime stories intertwine in a bold, nonlinear narrative."
        ),
        (
            "https://image.tmdb.org/t/p/w500/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
            "Star Wars: A New Hope",
            "A farm boy joins rebels in the battle against a powerful galactic empire."
        )
    ]
}
