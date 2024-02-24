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
        // Initialize the view controller from the nib file "WaetherViewController"
        let moduleViewController = WaetherViewController(nibName: "WaetherViewController", bundle: nil)

        // Initialize the wireframe with the view controller
        super.init(viewController: moduleViewController)

        // Initialize the formatter, interactor, and presenter
        let formatter = WaetherFormatter()
        let interactor = WaetherInteractor()
        let presenter = WaetherPresenter(view: moduleViewController, formatter: formatter, interactor: interactor, wireframe: self)

        // Set the presenter for the view controller
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

// Conform to the WaetherWireframeInterface protocol
extension WaetherWireframe: WaetherWireframeInterface {}
