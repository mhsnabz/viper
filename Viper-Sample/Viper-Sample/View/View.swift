//
//  View.swift
//  Viper-Sample
//
//  Created by srbrt on 21.02.2024.
//

import Foundation
// Protocol defining the necessary properties for any view class.
protocol AnyView {
    var presenter: AnyPresenter? { get set } // Property to hold a reference to the presenter.
}
