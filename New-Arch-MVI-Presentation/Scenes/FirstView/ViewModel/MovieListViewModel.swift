//
//  MovieListViewModel.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import Observation
import New_Arch_MVI_Domain
import Foundation

// MARK: - Parameters
public struct MovieListViewModelParameters { }

// MARK: - State
struct MovieListViewModelState {
    var data: MovieItemList
//    var isLoading: Bool
}

// MARK: - SideEffect
enum MovieListViewModelSideEffect {
    case navigateToDetailsPage
    case showEditPage
}

// MARK: - Intents
enum MovieListViewModelIntent {
    case didSelectMovie
    case removeAll
}

protocol MovieListViewModel: ViewModel where
    Parameters == MovieListViewModelParameters,
    State == MovieListViewModelState,
    Intent == MovieListViewModelIntent,
    SideEffect == MovieListViewModelSideEffect { }
    
@Observable
final class DefaultMovieListViewModel: MovieListViewModel {

    var state: MovieListViewModelState
    
    var onSideEffect: ((MovieListViewModelSideEffect) -> Void)?
    
    init(parameters: MovieListViewModelParameters) {
        state = .init(data: .init(movies: []))
    }
    
    func onLoad() {
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            state.data = .init(
                movies: moviesData.map { movie in
                        .init(
                            id: UUID(),
                            url: movie.url,
                            title: movie.title,
                            description: movie.description
                        )
                }
            )
        }
    }
    
    func handleIntent(_ intent: MovieListViewModelIntent) {
        switch intent {
        case .didSelectMovie:
            print("didSelectMovie")
        case .removeAll:
            state.data = .init(movies: [])
        }
    }
    
    let moviesData: [(
        url: String,
        title: String,
        description: String
    )] = [
        (
            "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg",
            "Interstellar",
            "A team of explorers travel beyond this galaxy to discover whether mankind has a future among the stars."
        ),
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
        )
    ]

    
}





protocol ViewModel: ViewModelInput, ViewModelOutput, ViewModelSideEffect {
    associatedtype Parameters
    init(parameters: Parameters)
    func onLoad()
    func onAppear()
}

// Temporary
extension ViewModel {
    func onAppear() {
        
    }
}

protocol ViewModelInput {
    associatedtype Intent
    
    /// Handles UI-driven actions (Intents)
    func handleIntent(_ intent: Intent)
}

protocol ViewModelOutput {
    associatedtype State
    var state: State { get }
}

protocol ViewModelSideEffect {
    associatedtype SideEffect
    var onSideEffect: ((SideEffect) -> Void)? { get set }
}
