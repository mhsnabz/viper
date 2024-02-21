//
//  Presenter.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import Foundation
// Protocol defining the necessary properties for any presenter class.
protocol AnyPresenter {
    var router: Router? { get set } // Property to hold a reference to the router.
    var interactor: AnyInteractor? { get set } // Property to hold a reference to the interactor.
    var view: AnyView? { get set } // Property to hold a reference to the view.
}

// Class managing the business logic on the server side and user interface interactions.
class MainPresenter: AnyPresenter {
    var router: Router? // Holds a reference to the router.
    var interactor: AnyInteractor? // Holds a reference to the interactor.
    var view: AnyView? // Holds a reference to the view.
}
