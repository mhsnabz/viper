//
//  SearchPlaceInterfaces.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import UIKit

protocol SearchPlaceWireframeInterface: WireframeInterface {}

protocol SearchPlaceViewInterface: ViewInterface {
    /// Updates the user interface.
    func updateUI()

    /// Shows the loading indicator.
    func showIndicator()

    /// Hides the loading indicator.
    func hideIndicator()
}

protocol SearchPlacePresenterInterface: PresenterInterface {
    /// Initiates a search request with the provided query.
    func searchPlace(_ query: String)

    /// Retrieves the list of search locations.
    func getLocations() -> [SearchLocationModel]

    /// Retrieves the search location item at the specified index path.
    func locationItem(at indexPath: IndexPath) -> SearchLocationModel?

    /// Returns the number of search locations in the list.
    func locationsNumberOfRowInSection() -> Int

    /// Cancels the ongoing search request.
    func cancelRequest()
}

protocol SearchPlaceFormatterInterface: FormatterInterface {}

protocol SearchPlaceInteractorInterface: InteractorInterface {
    /// Fetches the search result for the given query.
    /// - Parameters:
    ///   - query: The search query.
    ///   - completion: The completion handler to call when the request is complete.
    func getSearchResult(query: String, completion: @escaping (Result<[SearchLocationModel], APIError>) -> Void)

    /// Cancels the ongoing search request.
    func cancelRequest()
}

/// Protocol for notifying a delegate about selected place updates.
protocol SelectedPlaceDelegate: AnyObject {
    /// Updates the view with the selected place.
    func updateView()
}
