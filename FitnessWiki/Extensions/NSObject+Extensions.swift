//
//  NSObject+Extensions.swift
//  FitnessWiki
//
//  Created by AbdooMaaz's playground on 18.06.22.
//

import Foundation

extension NSObject {
    @objc static var className: String {
        String(describing: self)
    }
}
