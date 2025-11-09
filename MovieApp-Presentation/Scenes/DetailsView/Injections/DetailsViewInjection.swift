//
//  DetailsViewInjection.swift
//  MovieApp-Presentation
//
//  Created by Tornike Bardadze on 30.10.25.
//

internal import FactoryKit

extension Container {
    var detailsRouter: Factory<DetailsViewRouter> { self { DefaultDetailsViewRouter() } }
    var detailsFactory: Factory<DefaultDetailsViewFactory> { self { DefaultDetailsViewFactory() } }
}
