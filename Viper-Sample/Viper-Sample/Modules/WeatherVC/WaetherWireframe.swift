//
//  WaetherWireframe.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import UIKit

final class WaetherWireframe: BaseWireframe<WaetherViewController> {
    // MARK: - Module setup -

    init() {
        let moduleViewController = WaetherViewController(nibName: "WaetherViewController", bundle: nil)
        super.init(viewController: moduleViewController)

        let formatter = WaetherFormatter()
        let interactor = WaetherInteractor()
        let presenter = WaetherPresenter(view: moduleViewController, formatter: formatter, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension WaetherWireframe: WaetherWireframeInterface {}
