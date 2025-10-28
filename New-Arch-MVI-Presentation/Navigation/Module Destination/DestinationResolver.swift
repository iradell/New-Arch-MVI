//
//  DestinationResolver.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

struct AppDestinationResolver: DestinationResolver {
    func view(for destination: AppDestination) -> some View {
        switch destination {
        case .movieDetials:
            DetailsView()
        }
    }
}
