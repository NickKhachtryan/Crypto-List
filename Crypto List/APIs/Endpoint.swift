//
//  Endpoint.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 16.11.2024.
//

import Foundation

enum Endpoint {
    
    case fetchCoins(url: String = "/v1/cryprocurrency/listings/latest")
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "USD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            HTTP.Method.get.rawValue
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Header.Value.applicationJSON.rawValue, forHTTPHeaderField: HTTP.Header.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Header.Key.apiKey.rawValue)
        }
    }
}
