//
//  NetworkManger.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 16.06.22.
//

import Foundation

enum NetworkError: Error {
    case decodingError(String?)
    case domainError(String?)
    case urlError
}

typealias Completion<T> = (Result<T, NetworkError>) -> Void where T:Decodable

struct NetworkManger{
    
    func request<T:Decodable>(endpoint: Endpoint, type: T.Type, completion: @escaping Completion<T> ) {
        guard let urlRequest = buildRequest(with: endpoint) else {
            return completion(.failure(.urlError))
        }
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let responseData = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(.failure(NetworkError.domainError(error?.localizedDescription)))
                return
            }
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.domainError("Status code was \(httpResponse.statusCode), but expected 2xx")))
                return
            }
            do {
                let result = try jsonDecoder.decode(type, from: responseData)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
    }
    
    private func buildRequest(with endpoint: Endpoint) -> URLRequest? {
        let queryParams = endpoint.params?.map {key, value in URLQueryItem(name: key, value: "\(value)")}
        
        var urlComponents = URLComponents(string: endpoint.baseUrl + endpoint.path)
        urlComponents?.queryItems = queryParams
        
        guard let url = urlComponents?.url else { return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        return urlRequest
    }
}
