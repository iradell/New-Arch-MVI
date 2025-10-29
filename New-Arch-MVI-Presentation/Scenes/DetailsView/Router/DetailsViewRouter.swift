//
//  DetailsViewRouter.swift
//  New-Arch-MVI-Presentation
//
//  Created by Tornike Bardadze on 30.10.25.
//

internal import FactoryKit
internal import New_Arch_MVI_Navigation

public protocol DetailsViewRouter: AnyObject {
    func navigateToSubscription()
}

public class DefaultDetailsViewRouter: DetailsViewRouter {
    
    @Injected(\.navigator) private var navigator
    
    public func navigateToSubscription() {
        navigator.navigate(to: .subscriptionPlanDetails)
    }
    
}
