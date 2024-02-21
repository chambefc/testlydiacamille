//
//  RequestBuilder.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import Foundation

private enum Constants {
    static let baseURLKey = "API_BASE_URL"
}

protocol RequestBuilderType {
    func request(for endpoint: Endpoint) -> URLRequest?
}

/// Handles the creation of an URLRequest. If not provided a custom baseURL, will default to the default baseURL contained in the Info.plist file.
final class RequestBuilder: RequestBuilderType {

    private let baseURL: URL


    /// Init
    /// - Parameter baseURL: This init allows to inject a specific Base URL to use.
    /// It will be stored and used for the whole component lifecycle.
    /// Default value for the base URL will be the API_BASE_URL contained in the Info.plist file
    init(baseURL: URL? = nil) {
        if let baseURL {
            self.baseURL = baseURL
        } else {
            guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: Constants.baseURLKey) as? String,
                  let baseURL = URL(string: baseURLString) else {
                fatalError("Base URL was not set in Info.plist")
            }
            self.baseURL = baseURL
        }
    }


    /// Builds a request to feed the NetworkClient
    /// - Parameter endpoint: The endpoint to use
    /// - Returns: Returns a `URLRequest` object for the NetworkClient to perform
    func request(for endpoint: Endpoint) -> URLRequest? {
        var url = baseURL
        url.append(path: endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let parameters = endpoint.parameters {
            var queryItems = [URLQueryItem]()
            for (_, parameter) in parameters.enumerated() {
                queryItems.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
            request.url?.append(queryItems: queryItems)
        }
        return request
    }

}
