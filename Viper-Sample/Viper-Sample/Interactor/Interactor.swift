//
//  Interactor.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import Foundation
// Protocol defining the necessary properties for any interactor class.
protocol AnyInteractor {
    var presenter: AnyPresenter? { get set } // Property to hold a reference to the presenter.
}

// Class that performs the business logic and implements the AnyInteractor protocol.
class MainInteractor: AnyInteractor {
    var presenter: AnyPresenter? // Holds a reference to the presenter.
}
