//
//  Collection+Extensions.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 19.06.22.
//  source of the method: https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
