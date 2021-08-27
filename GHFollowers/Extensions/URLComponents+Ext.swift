//
//  URLComponents+Ext.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-26.
//

import Foundation

extension URLComponents {
    static func createEndpointURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) -> String {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let constructedURL = components.url else { return "" }
        return constructedURL.absoluteString
    }
}
