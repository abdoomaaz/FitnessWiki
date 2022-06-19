//
//  ExerciseEndpoint.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

enum ExerciseEndpoint: Endpoint {
    case exersicesList(request: ExercisesListRequest)
    var baseUrl: String {
        Constants.url
    }
    
    var path: String {
        Constants.path
    }
    
    var params: [String : Any]? {
        switch self {
        case .exersicesList(let request):
            return request.params
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .exersicesList(let request):
            return request.headers
        }
    }
    
    var method: HTTPMethods {
        .get
    }
}


private extension ExerciseEndpoint {
    enum Constants {
        static let url = "https://api.api-ninjas.com"
        static let path = "/v1/exercises"
    }
}
