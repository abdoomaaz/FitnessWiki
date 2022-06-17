//
//  Exercise.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

struct Exercise: Decodable{
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}
