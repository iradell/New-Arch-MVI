//
//  ApiMovieItemList.swift
//  New-Arch-MVI-Data
//
//  Created by Tornike Bardadze on 25.10.25.
//

import Foundation

// MARK: - Movie API Model

public struct ApiMovieItemListModel: Decodable {
    public let movies: [ApiMovieItemModel]

    public init(movies: [ApiMovieItemModel]) {
        self.movies = movies
    }
}

public struct ApiMovieItemModel: Decodable, Identifiable {
    public let id: String
    public let url: String
    public let title: String
    public let description: String

    public init(
        id: String,
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

// MARK: - Mock Data (for development)

extension ApiMovieItemListModel {
    public static func mock() -> ApiMovieItemListModel {
        let mockMovies: [ApiMovieItemModel] = [
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
                title: "The Dark Knight",
                description: "Batman faces his greatest psychological and physical challenges when the Joker wreaks havoc on Gotham."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg",
                title: "Avatar",
                description: "A paraplegic Marine on a mission to Pandora finds himself torn between obeying orders and protecting a new world."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg",
                title: "Avengers: Endgame",
                description: "The Avengers assemble once more in a race to undo Thanos' devastation and restore balance to the universe."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg",
                title: "Iron Man",
                description: "After escaping captivity, billionaire Tony Stark uses his tech genius to become the armored hero Iron Man."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
                title: "Spider-Man: No Way Home",
                description: "Spider-Man faces multiverse-shattering consequences when his identity is exposed to the world."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
                title: "Joker",
                description: "An isolated comedian descends into madness and becomes the iconic criminal mastermind known as the Joker."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
                title: "Titanic",
                description: "A sweeping love story unfolds aboard the tragic maiden voyage of the RMS Titanic."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
                title: "Dune",
                description: "A brilliant young man must travel to the most dangerous planet in the universe to secure the future of his people."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/wqnLdwVXoBjKibFRR5U3y0aDUhs.jpg",
                title: "Star Wars: The Force Awakens",
                description: "A new threat rises as heroes old and new unite in the fight against the First Order."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
                title: "The Matrix",
                description: "A hacker discovers the world he knows is a simulation and joins a rebellion against its creators."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg",
                title: "Guardians of the Galaxy Vol. 3",
                description: "The Guardians must band together to protect one of their own while facing a dangerous new enemy."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/drlfSCIlMKrEeMPhi8pqY4xGxj.jpg",
                title: "Inception",
                description: "A skilled thief enters people's dreams to steal secrets, but a final mission could cost everything."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/v5CfpzxoJDkZxjZAizClFdlEF0U.jpg",
                title: "The Social Network",
                description: "The creation of Facebook sparks innovation, conflict, and legal battles."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg",
                title: "Spirited Away",
                description: "A young girl becomes trapped in a mysterious spirit world and must find her way home."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/7lyBcpYB0Qt8gYhXYaEZUNlNQAv.jpg",
                title: "Pulp Fiction",
                description: "Multiple crime stories intertwine in a bold, nonlinear narrative."
            ),
            ApiMovieItemModel(
                id: UUID().uuidString,
                url: "https://image.tmdb.org/t/p/w500/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
                title: "Star Wars: A New Hope",
                description: "A farm boy joins rebels in the battle against a powerful galactic empire."
            )
        ]

        return ApiMovieItemListModel(movies: mockMovies)
    }
}
