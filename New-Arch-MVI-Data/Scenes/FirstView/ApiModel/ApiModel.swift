//
//  ApiModel.swift
//  New-Arch-MVI-Data
//
//  Created by Tornike Bardadze on 25.10.25.
//

import Foundation

// MARK: - Movie API Model

public struct MovieItemListApiModel: Decodable {
    public let movies: [MovieItemApiModel]

    public init(movies: [MovieItemApiModel]) {
        self.movies = movies
    }
}

public struct MovieItemApiModel: Decodable, Identifiable {
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

extension MovieItemListApiModel {
    public static func mock() -> MovieItemListApiModel {
        let mockMovies: [MovieItemApiModel] = [
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
                title: "The Dark Knight",
                description: "Batman faces his greatest psychological and physical challenges when the Joker wreaks havoc on Gotham."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/kyeqWdyUXW608qlYkRqosgbbJyK.jpg",
                title: "Avatar",
                description: "A paraplegic Marine on a mission to Pandora finds himself torn between obeying orders and protecting a new world."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg",
                title: "Avengers: Endgame",
                description: "The Avengers assemble once more in a race to undo Thanos' devastation and restore balance to the universe."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/78lPtwv72eTNqFW9COBYI0dWDJa.jpg",
                title: "Iron Man",
                description: "After escaping captivity, billionaire Tony Stark uses his tech genius to become the armored hero Iron Man."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
                title: "Spider-Man: No Way Home",
                description: "Spider-Man faces multiverse-shattering consequences when his identity is exposed to the world."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
                title: "Joker",
                description: "An isolated comedian descends into madness and becomes the iconic criminal mastermind known as the Joker."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
                title: "Titanic",
                description: "A sweeping love story unfolds aboard the tragic maiden voyage of the RMS Titanic."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
                title: "Dune",
                description: "A brilliant young man must travel to the most dangerous planet in the universe to secure the future of his people."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/wqnLdwVXoBjKibFRR5U3y0aDUhs.jpg",
                title: "Star Wars: The Force Awakens",
                description: "A new threat rises as heroes old and new unite in the fight against the First Order."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg",
                title: "The Matrix",
                description: "A hacker discovers the world he knows is a simulation and joins a rebellion against its creators."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg",
                title: "Guardians of the Galaxy Vol. 3",
                description: "The Guardians must band together to protect one of their own while facing a dangerous new enemy."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/drlfSCIlMKrEeMPhi8pqY4xGxj.jpg",
                title: "Inception",
                description: "A skilled thief enters people's dreams to steal secrets, but a final mission could cost everything."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/v5CfpzxoJDkZxjZAizClFdlEF0U.jpg",
                title: "The Social Network",
                description: "The creation of Facebook sparks innovation, conflict, and legal battles."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/q719jXXEzOoYaps6babgKnONONX.jpg",
                title: "Spirited Away",
                description: "A young girl becomes trapped in a mysterious spirit world and must find her way home."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/7lyBcpYB0Qt8gYhXYaEZUNlNQAv.jpg",
                title: "Pulp Fiction",
                description: "Multiple crime stories intertwine in a bold, nonlinear narrative."
            ),
            MovieItemApiModel(
                id: UUID().uuidString,
                url: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
                title: "Star Wars: A New Hope",
                description: "A farm boy joins rebels in the battle against a powerful galactic empire."
            )
        ]

        return MovieItemListApiModel(movies: mockMovies)
    }
}
