//
//  Endpoint.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 16.06.22.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var method: HTTPMethods { get }
}
