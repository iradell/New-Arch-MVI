//
//  FirstViewFlowCoordinator.swift
//  New-Arch-MVI-Api
//
//  Created by Tornike Bardadze on 23.10.25.
//

import SwiftUI

public protocol FirstViewFlowCoordinator {
    associatedtype ModuleView: View
    
    @MainActor
    func firstView() -> ModuleView
}
