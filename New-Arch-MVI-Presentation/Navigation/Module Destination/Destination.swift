//
//  Destination.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

enum AppDestination: Hashable, Identifiable {
    case movieDetials
    
    var id: String {
        switch self {
        case .movieDetials:
            "movieDetials"
        }
    }
}

