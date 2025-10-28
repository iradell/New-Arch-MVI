//
//  ViewHelper.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

extension View {
    func withNavigation() -> some View {
        NavigationContainer { self }
    }
}
