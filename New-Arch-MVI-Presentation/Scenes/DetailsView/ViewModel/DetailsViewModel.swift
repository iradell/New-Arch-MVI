//
//  DetailsViewModel.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 30.10.25.
//

import Observation
import New_Arch_MVI_Domain
internal import New_Arch_MVI_PresentationCore
internal import FactoryKit
import Foundation

// MARK: - Parameters
public struct DetailsViewModelParameters: Equatable, Hashable {
    var image: URL
    var title: String
    var description: String
}

// MARK: - State
struct DetailsViewModelState {
    var data: DetailsViewModelParameters
}

// MARK: - SideEffect
enum DetailsViewModelSideEffect {
    case navigateToDetailsPage
    case showEditPage
}

// MARK: - Intents
enum DetailsViewModelIntent {
    case navigateToSubscription
}

protocol DetailsViewModel: ViewModel where
    Parameters == DetailsViewModelParameters,
    State == DetailsViewModelState,
    Intent == DetailsViewModelIntent,
    SideEffect == DetailsViewModelSideEffect { }
    
@Observable
final class DefaultDetailsViewModel: DetailsViewModel {
    
    @ObservationIgnored
    @Injected(\.detailsRouter) private var router
    
    var state: DetailsViewModelState
    
    var onSideEffect: ((DetailsViewModelSideEffect) -> Void)?
    
    init(parameters: DetailsViewModelParameters) {
        state = .init(data: parameters)
    }
    
    func handleIntent(_ intent: DetailsViewModelIntent) {
        switch intent {
        case .navigateToSubscription:
            print("Navigate")
        }
    }
    
}
