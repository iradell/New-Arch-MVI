//
//  AppDestinationResolver.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI
internal import New_Arch_MVI_Navigation

struct AppDestinationResolver: DestinationResolver {
    func view(for destination: AppDestination) -> some View {
        switch destination {
        case .movieDetials:
            DetailsView()
        }
    }
}
