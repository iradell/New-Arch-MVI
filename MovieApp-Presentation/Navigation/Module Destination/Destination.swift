//
//  Destination.swift
//  MovieApp-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

enum AppDestination: Hashable, Identifiable {
    case movieDetials(DetailsViewModelParameters)
    case subscriptionPlanDetails
    
    var id: String {
        switch self {
        case .movieDetials:
            "movieDetials"
        case .subscriptionPlanDetails:
            "subscriptionPlanDetails"
        }
    }
}

