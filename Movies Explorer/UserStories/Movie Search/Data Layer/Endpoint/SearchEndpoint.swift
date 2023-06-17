//
//  SearchEndpoint.swift
//  Movies Explorer
//
//  Created by Temirlan on 17.06.2023.
//

import Foundation

enum SearchEndpoint {
    case movies(query: String, page: Int)
}

extension SearchEndpoint: RequestProviding {
    var shouldAddAuthorizationToken: Bool {
        return true
    }
    
    var urlRequest: URLRequest {
        switch self {
        case .movies(let query, let page):
            guard let url = URL(string: Constants.apiHost + "/search/movie") else { fatalError() }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            queryItems.append(URLQueryItem(name: "language", value: "en-US"))
            queryItems.append(.init(name: "include_adult", value: "true"))
            components?.queryItems = queryItems
            guard let componentsURL = components?.url else { fatalError() }
            let urlRequest = URLRequest(url: componentsURL)
            return urlRequest
        }
    }
}
