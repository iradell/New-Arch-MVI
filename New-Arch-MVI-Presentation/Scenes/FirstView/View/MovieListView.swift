//
//  MovieListView.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 23.10.25.
//

import SwiftUI
import New_Arch_MVI_Domain

struct MovieListView<ViewModel: MovieListViewModel>: View {
    
    var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 170))
                ],
                alignment: .center,
                spacing: 20
            ) {
                ForEach(viewModel.state.data.movies) { item in
                    MovieItemView(
                        url: URL(string: item.url)!,
                        title: item.title
                    )
                }
            }
        }
        .refreshable(action: {
            viewModel.handleIntent(.removeAll)
        })
        .onAppear {
            viewModel.onLoad()
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

private struct MovieItemView: View {
    let url: URL
    let title: String
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: 10
        ) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 200)
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            .clipped()
            .shadow(radius: 4)
            Text(title)
        }
    }
}
