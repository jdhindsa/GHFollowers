//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jason Dhindsa on 2021-08-18.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let scheme = "https"
    let host = "api.github.com"
    let cache = NSCache<NSString, UIImage>()
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let resultsPerPage: URLQueryItem = URLQueryItem(name: "per_page", value: "100")
        let pageToRetrieve: URLQueryItem = URLQueryItem(name: "page", value: "1")
        fetchData(endpoint: generateEndpointURL(path: "/users/\(username)/followers", queryItems: [resultsPerPage, pageToRetrieve]), completion: completion)
    }
    
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
        fetchData(endpoint: generateEndpointURL(path: "/users/\(username)"), completion: completion)
    }
    
    private func generateEndpointURL(path: String, queryItems: [URLQueryItem] = []) -> String {
        return URLComponents.createEndpointURL(scheme: scheme, host: host, path: path, queryItems: queryItems)
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode),
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, GFError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        let task = session.dataTask(with: url) { data, response, error in

            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
