//
//  SearchPlaceInteractor.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//
//

import Foundation

/// The `SearchPlaceInteractor` class handles the business logic for searching locations.
final class SearchPlaceInteractor {
    private let service: SearchLocationService

    /// Initializes an instance of `SearchPlaceInteractor`.
    /// - Parameter service: The service responsible for handling location search requests.
    init(service: SearchLocationService = .shared) {
        self.service = service
    }
}

// MARK: - Extensions -

extension SearchPlaceInteractor: SearchPlaceInteractorInterface {
    /// Fetches search results for the given query.
    /// - Parameters:
    ///   - query: The search query.
    ///   - completion: The completion handler to call when the request finishes, containing the search results or an error.
    func getSearchResult(query: String, completion: @escaping (Result<[SearchLocationModel], APIError>) -> Void) {
        service.getSearchResult(query: query) { result in
            completion(result)
        }
    }

    /// Cancels the ongoing search request.
    func cancelRequest() {
        service.cancelSearch()
    }
}
