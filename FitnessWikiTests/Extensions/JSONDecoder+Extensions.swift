//
//  JSONDecoder+Extensions.swift
//  FitnessWikiTests
//
//  Created by AbdooMaaz's playground on 28.06.22.
//

import Foundation

extension JSONDecoder {
    static func loadJson<T:Decodable>(type: T.Type, filename fileName: String, bundle: Bundle) -> T {
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(type, from: data)
                return jsonData
            } catch {
                fatalError("error: \(error)")
            }
        }
        fatalError("Invalid filename")
    }
}
