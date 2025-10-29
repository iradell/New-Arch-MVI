//
//  Navigator.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

protocol Navigator {
    associatedtype Destination: Hashable & Identifiable

    var path: NavigationPath { get set }
    var presentedSheet: Destination? { get set }
    var presentedFullScreen: Destination? { get set }
    
    func navigate(to: Destination)
    func presentSheet(_ destination: Destination)
    func presentFullScreen(_ destination: Destination)

    func pop()
    func popToRoot()
}

@Observable
class DefaultNavigator<Destination: Hashable & Identifiable>: Navigator {
    var path = NavigationPath()
    var presentedSheet: Destination? = nil
    var presentedFullScreen: Destination? = nil
    
    func navigate(to destination: Destination) {
          var newPath = path
          newPath.append(destination)
          path = newPath
      }
    
    func presentSheet(_ destination: Destination) { presentedSheet = destination }
    func presentFullScreen(_ destination: Destination) { presentedFullScreen = destination }
    
    func pop() { path.removeLast() }
    func popToRoot() { path = NavigationPath() }
}

