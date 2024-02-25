//
//  SearchLocationService.swift
//  Viper-Sample
//
//  Created by srbrt on 25.02.2024.
//

import Foundation

class SearchLocationService {
    static let shared = SearchLocationService()

    private var dataTask: URLSessionDataTask?

    func getSearchResult(query: String, completion: @escaping (Result<[SearchLocationModel], APIError>) -> Void) {
        guard let url = buildURL(searchQuery: query) else {
            completion(.failure(.invalidURL))
            return
        }

        // Eğer varsa mevcut bir data task varsa iptal et
        dataTask?.cancel()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponseCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let locations = try JSONDecoder().decode([SearchLocationModel].self, from: data)
                completion(.success(locations))
            } catch {
                print("error :\(error.localizedDescription)")
                completion(.failure(.decodingError(error)))
            }
        }

        // Oluşturulan task'ı kaydet
        dataTask = task

        task.resume()
    }

    private func buildURL(searchQuery: String) -> URL? {
        var components = URLComponents(string: ApiConstant.Search.baseUrl)
        components?.queryItems = [
            URLQueryItem(name: "q", value: searchQuery),
            URLQueryItem(name: "format", value: "json"),
        ]
        return components?.url
    }

    // İsteği iptal etmek için bir fonksiyon
    func cancelSearch() {
        dataTask?.cancel()
    }
}
