//
//  Errors.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/26/21.
//

import Foundation

enum RegexError: Error {
    case failedToGetRange(range: NSRange, string: String)

    var errorDescription: String? {
        switch self {
        case .failedToGetRange(let range, let string):
            return "Failed to get range at: \(range) from: \(string)"
        }
    }
}
