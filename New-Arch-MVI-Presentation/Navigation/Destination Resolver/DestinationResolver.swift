//
//  DestinationResolver.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

public protocol DestinationResolver {
    associatedtype Destination: Hashable & Identifiable
    associatedtype DestinationView: View
    
    @ViewBuilder
    func view(for destination: Destination) -> DestinationView
}
