//
//  SearchPlaceWireframe.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import UIKit

final class SearchPlaceWireframe: BaseWireframe<SearchPlaceViewController> {
    // MARK: - Module setup -

    init() {
        let moduleViewController = SearchPlaceViewController()
        super.init(viewController: moduleViewController)

        let formatter = SearchPlaceFormatter()
        let interactor = SearchPlaceInteractor()
        let presenter = SearchPlacePresenter(view: moduleViewController, formatter: formatter, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension SearchPlaceWireframe: SearchPlaceWireframeInterface {}
