//
//  SearchPlacePresenter.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import Foundation

final class SearchPlacePresenter {
    // MARK: - Private properties -

    private unowned let view: SearchPlaceViewInterface
    private let formatter: SearchPlaceFormatterInterface
    private let interactor: SearchPlaceInteractorInterface
    private let wireframe: SearchPlaceWireframeInterface

    // MARK: - Lifecycle -

    init(view: SearchPlaceViewInterface, formatter: SearchPlaceFormatterInterface, interactor: SearchPlaceInteractorInterface, wireframe: SearchPlaceWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension SearchPlacePresenter: SearchPlacePresenterInterface {}
