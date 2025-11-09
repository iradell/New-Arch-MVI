//
//  MovieListView.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import SwiftUI
import New_Arch_MVI_Domain
internal import New_Arch_MVI_PresentationCore

struct MovieListView<ViewModel: MovieListViewModel>: View {
    
    var viewModel: ViewModel
    
    // MARK: - Body
    var body: some View {
        content
            .onLoad {
                viewModel.onLoad()
            }
            .refreshable {
                viewModel.handleIntent(.removeAll)
                viewModel.onLoad()
            }
    }
    
    @ViewBuilder
    private var content : some View {
        switch viewModel.state.data {
        case .loading:
            loadingView
        case .success(let data):
            moviesGrid(data.movies)
        case .failure(let error):
            errorView(error)
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView("Loading movies...")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
    
    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 12) {
            Text("Failed to fetch movies")
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.red)
            Button("Retry") {
                viewModel.onLoad()
            }
        }
        .padding()
    }
    
    // MARK: - Mock UI View
    private let gridColumns = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 3
    )
    
    private func moviesGrid(_ items: [MovieItem]) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // MARK: - Top Featured Horizontal List
                mostWatchedCarousel(items.shuffled())
                
                // MARK: - Vertical Grid
                LazyVGrid(columns: gridColumns, spacing: 24) {
                    ForEach(items) { item in
                        MovieItemView(
                            url: URL(string: item.url)!,
                            title: item.title
                        )
                        .onTapGesture {
                            viewModel.handleIntent(.didSelectMovie(item))
                        }
                    }
                }
            }
            .padding(.vertical, 12)
        }
    }
    
    private func mostWatchedCarousel(_ items: [MovieItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("🔥 Most Watched")
                .font(.title3.bold())
                .foregroundColor(.primary)
                .padding(.horizontal, 8)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items.prefix(8)) { item in
                        FeaturedMovieView(
                            url: URL(string: item.url)!,
                            title: item.title
                        )
                        .onTapGesture {
                            viewModel.handleIntent(.didSelectMovie(item))
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    MovieListView(
        viewModel: DefaultMovieListViewModel(
            parameters: .init()
        )
    )
}
