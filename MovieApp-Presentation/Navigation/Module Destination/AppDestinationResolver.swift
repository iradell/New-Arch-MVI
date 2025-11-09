//
//  AppDestinationResolver.swift
//  MovieApp-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI
internal import New_Arch_MVI_Navigation
internal import FactoryKit

struct AppDestinationResolver: DestinationResolver {
    
    @Injected(\.detailsFactory) private var detailsFactory
    
    func view(for destination: AppDestination) -> some View {
        switch destination {
        case .movieDetials(let parameters):
            detailsFactory.make(parameters: parameters)
        case .subscriptionPlanDetails:
            EmptyView()
        }
    }
}
