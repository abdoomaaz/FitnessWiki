//
//  NetworkManger.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 16.06.22.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case apiError(String?)
    case urlError
}

typealias Completion<T> = (Result<T, NetworkError>) -> Void where T:Decodable

struct NetworkManger{
    
    func request<T:Decodable>(endpoint: Endpoint, type: T.Type, completion: @escaping Completion<T> ) {
        guard let urlRequest = buildRequest(with: endpoint) else {
            completion(.failure(.urlError))
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let responseData = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(.failure(NetworkError.apiError(error?.localizedDescription)))
                return
            }
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                if 400 ..< 500 ~= httpResponse.statusCode {
                    // The problem with Apis-ninjas' endpoints, it returns unauthorised when a bad request is sent ex: /exercisea (typo)
                    // BUT it returns bad request when api-key is invalid or missing, thus proper error handling is not possible. Support contacted.
                    completion(.failure(NetworkError.apiError("BAD REQUEST")))
                    NSLog("Bad request, Status code: %d", httpResponse.statusCode)
                    return
                }
                else {
                    completion(.failure(NetworkError.apiError("Internal Server Error")))
                    NSLog("Internal Server error, Status code: %d", httpResponse.statusCode)
                    return
                }
            }
            do {
                let result = try jsonDecoder.decode(type, from: responseData)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                completion(.failure(.decodingError))
                print("decodingError: \(error)")
            }
        }.resume()
    }
    
    private func buildRequest(with endpoint: Endpoint) -> URLRequest? {
        let queryParams = endpoint.params?.map { key, value in URLQueryItem(name: key, value: "\(value)")}
        var urlComponents = URLComponents(string: endpoint.baseUrl + endpoint.path)
        urlComponents?.queryItems = queryParams
        guard let url = urlComponents?.url else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        //_ = endpoint.headers?.map { key, value in urlRequest.setValue(value, forHTTPHeaderField: key)}
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        return urlRequest
    }
}
