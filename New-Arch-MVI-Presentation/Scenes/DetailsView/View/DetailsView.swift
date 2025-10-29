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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailsView(
        viewModel: DefaultDetailsViewModel(
            parameters: .init(
                image: nil,
                description: ""
            )
        )
    )
}
