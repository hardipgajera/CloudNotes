//
//  Extension.swift
//  CloudNotes
//
//  Created by hardip gajera on 23/05/22.
//

import Foundation

extension Optional {
    var asEmptyOrString: String {
        switch self {
        case .none:
            return ""
        case .some(let wrapped):
            return "\(wrapped)"
        }
    }
}
