//
//  WaetherViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 23.02.2024.
//
//

import UIKit

final class WaetherViewController: UIViewController {
    // MARK: - Public properties -

    var presenter: WaetherPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extensions -

extension WaetherViewController: WaetherViewInterface {}
