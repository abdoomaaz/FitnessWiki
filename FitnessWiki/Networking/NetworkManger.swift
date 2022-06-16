//
//  NetworkManger.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 16.06.22.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

typealias Completion<T> = (Result<T, NetworkError>) -> Void where T:Decodable

struct NetworkManger{
    
    func request<T:Decodable>(endpoint: Endpoint, type: T.Type, completion: @escaping Completion<T> ) {
        //
    }
    
    private func buildRequest(with endpoint: Endpoint) throws -> URLRequest? {
        let queryParams = endpoint.params?.map {key, value in URLQueryItem(name: key, value: "\(value)")}
        
        var urlComponents = URLComponents(string: endpoint.baseUrl + endpoint.path)
        urlComponents?.queryItems = queryParams
        
        guard let url = urlComponents?.url else { throw NetworkError.decodingError }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        return urlRequest
    }
}
