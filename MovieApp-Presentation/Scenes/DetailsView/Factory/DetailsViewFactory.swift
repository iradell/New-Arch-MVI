//
//  DetailsViewFactory.swift
//  MovieApp-Presentation
//
//  Created by Tornike Bardadze on 30.10.25.
//

internal import New_Arch_MVI_PresentationCore

// MARK: - DetailsViewFactory
protocol DetailsViewFactory: ViewFactory where
    Parameters == DetailsViewModelParameters,
    View == DetailsView<DefaultDetailsViewModel> {}

// MARK: - DefaultDetailsViewFactory
final class DefaultDetailsViewFactory: DetailsViewFactory {
    
    func make(parameters: DetailsViewModelParameters) -> DetailsView<DefaultDetailsViewModel> {
        let viewModel = DefaultDetailsViewModel(
            parameters: parameters
        )
        return DetailsView(viewModel: viewModel)
    }
    
}
