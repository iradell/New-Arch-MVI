//
//  DetailsView.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI
internal import New_Arch_MVI_PresentationCore

struct DetailsView<ViewModel: DetailsViewModel>: View {
     
    var viewModel: ViewModel
    
     var body: some View {
         ScrollView {
             VStack(spacing: 20) {

                 // Big Image
                 AsyncImage(url: viewModel.state.data.image) { phase in
                     switch phase {
                     case .empty:
                         ProgressView()
                             .frame(height: 350)
                     case .success(let image):
                         image
                             .resizable()
                             .scaledToFill()
                             .frame(height: 350)
                             .clipped()
                     case .failure:
                         Image(systemName: "photo.fill")
                             .resizable()
                             .scaledToFit()
                             .frame(height: 350)
                             .foregroundStyle(.gray)
                     @unknown default:
                         EmptyView()
                     }
                 }
                 .frame(maxWidth: .infinity)
                 .frame(height: 350)
                 .background(Color.gray.opacity(0.2))
                 .cornerRadius(16)
                 .shadow(radius: 8)
                 .padding(.horizontal, 16)
                 .padding(.top, 8)

                 // Title
                 Text(viewModel.state.data.title)
                     .font(.title)
                     .fontWeight(.bold)
                     .multilineTextAlignment(.leading)
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .padding(.horizontal, 16)

                 // Description
                 Text(viewModel.state.data.description)
                     .font(.body)
                     .foregroundStyle(.secondary)
                     .multilineTextAlignment(.leading)
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .padding(.horizontal, 16)

                 Spacer(minLength: 32)

                 // Subscription Button
                 Button(action: {
                     print("Subscribe tapped")
                 }) {
                     Text("Subscribe")
                         .font(.headline)
                         .foregroundStyle(.white)
                         .frame(maxWidth: .infinity)
                         .padding(.vertical, 16)
                         .background(.blue)
                         .cornerRadius(12)
                 }
                 .padding(.horizontal, 16)
                 .padding(.bottom, 16)
             }
         }
         .navigationTitle("Film Details")
         .navigationBarTitleDisplayMode(.inline)
     }
}


#Preview {
    DetailsView(
        viewModel: DefaultDetailsViewModel(
            parameters: .init(
                image: URL(
                    string: ""
                )!,
                title: "Title",
                description: "Description"
            )
        )
    )
}
