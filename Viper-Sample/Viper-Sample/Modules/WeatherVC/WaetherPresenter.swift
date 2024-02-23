//
//  WaetherPresenter.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import Foundation

final class WaetherPresenter {
    // MARK: - Private properties -

    private unowned let view: WaetherViewInterface
    private let formatter: WaetherFormatterInterface
    private let interactor: WaetherInteractorInterface
    private let wireframe: WaetherWireframeInterface

    // MARK: - Lifecycle -

    init(view: WaetherViewInterface, formatter: WaetherFormatterInterface, interactor: WaetherInteractorInterface, wireframe: WaetherWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension WaetherPresenter: WaetherPresenterInterface {}
