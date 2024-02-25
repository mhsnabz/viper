//
//  SearchPlaceViewController.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import UIKit

final class SearchPlaceViewController: UIViewController {
    // MARK: - Public properties -

    var presenter: SearchPlacePresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extensions -

extension SearchPlaceViewController: SearchPlaceViewInterface {
    func isLoading() {}

    func stopLoading() {}
}
