//
//  Router.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

@Observable
class Router<Destination: Hashable & Identifiable> {
    var path = NavigationPath()
    var presentedSheet: Destination? = nil
    var presentedFullScreen: Destination? = nil
    
    func navigate(to destination: Destination) { path.append(destination) }
    func presentSheet(_ destination: Destination) { presentedSheet = destination }
    func presentFullScreen(_ destination: Destination) { presentedFullScreen = destination }
    
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}
