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

    private var adressList: [SearchLocationModel] = []

    // MARK: - Lifecycle -

    /// Initializes a new instance of `SearchPlacePresenter`.
    /// - Parameters:
    ///   - view: The view interface.
    ///   - formatter: The formatter interface.
    ///   - interactor: The interactor interface.
    ///   - wireframe: The wireframe interface.
    init(view: SearchPlaceViewInterface, formatter: SearchPlaceFormatterInterface, interactor: SearchPlaceInteractorInterface, wireframe: SearchPlaceWireframeInterface) {
        self.view = view
        self.formatter = formatter
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension SearchPlacePresenter: SearchPlacePresenterInterface {
    /// Cancels the ongoing search request.
    func cancelRequest() {
        interactor.cancelRequest()
    }

    /// Retrieves the list of search locations.
    func getLocations() -> [SearchLocationModel] {
        adressList
    }

    /// Retrieves the search location item at the specified index path.
    func locationItem(at indexPath: IndexPath) -> SearchLocationModel? {
        if !adressList.isEmpty {
            return adressList[indexPath.row]
        }
        return nil
    }

    /// Returns the number of search locations in the list.
    func locationsNumberOfRowInSection() -> Int {
        adressList.count
    }

    /// Initiates a search request with the provided query.
    /// - Parameter query: The search query.
    func searchPlace(_ query: String) {
        view.showIndicator()
        interactor.getSearchResult(query: query) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(success):
                self.adressList = success
                self.view.hideIndicator()
                self.view.updateUI()
            case let .failure(failure):
                self.view.hideIndicator()
            }
        }
    }
}
