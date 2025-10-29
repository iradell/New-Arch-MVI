//
//  Navigator.swift
//  New-Arch-MVI-Presentation
//
//  Created by Giorgi Obgaidze on 27.10.25.
//

import SwiftUI

public protocol Navigator: AnyObject {
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
public class DefaultNavigator<Destination: Hashable & Identifiable>: Navigator {
    public var path = NavigationPath()
    public var presentedSheet: Destination? = nil
    public var presentedFullScreen: Destination? = nil
    
    public func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    public func presentSheet(_ destination: Destination) {
        presentedSheet = destination
    }
    
    public func presentFullScreen(_ destination: Destination) {
        presentedFullScreen = destination
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path = NavigationPath()
    }
}

