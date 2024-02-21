//
//  Router.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import UIKit
// Type alias defining a view and the AnyView protocol.
typealias EntryPoint = AnyView & UIViewController
// Protocol managing the navigation operations of the application.
protocol Router {
    var entryPoint: EntryPoint? { get } // Property to hold a reference to the entry point.
    static func start() -> Router // Method to start the router and return an instance.
}

// Class managing the navigation operations of the application and implementing the Router protocol.
class MainRouter: Router {
    var entryPoint: EntryPoint? // Holds a reference to the entry point.

    static func start() -> Router {
        let router = MainRouter()
        var view: AnyView = SplashViewController() // Create an instance of the view.
        var presenter: AnyPresenter = MainPresenter() // Create an instance of the presenter.
        var interactor: AnyInteractor = MainInteractor() // Create an instance of the interactor.
        view.presenter = presenter // Connect the view to the presenter.
        interactor.presenter = presenter // Connect the interactor to the presenter.
        presenter.router = router // Connect the presenter to the router.
        presenter.view = view // Connect the presenter to the view.
        router.entryPoint = view as? EntryPoint // Set the entry point of the router.
        return router // Return the router instance.
    }
}
