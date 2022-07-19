//
//  Rule.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation
import SwiftUI

struct RulesObject: Decodable, Hashable {
    let rules: [Category]
    let glossary: [GlossaryTerm]
}

struct Category: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let subcategories: [Subcategory]

    var label: String {
        "\(id). \(title)"
    }
}

struct Subcategory: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let rules: [Rule]

    var label: String {
        "\(id). \(title)"
    }
}

struct Rule: Codable, Identifiable, Hashable {
    let id: String
    let rule: String
    let subrules: [Subrule]

    var label: String {
        "\(id). \(rule)"
    }
}

struct Subrule: Codable, Identifiable, Hashable {
    let id: String
    let rule: String

    var label: String {
        "\(id). \(rule)"
    }
}

struct GlossaryTerm: Codable, Identifiable, Hashable {
    var id: String { term }
    let term: String
    let meanings: [String]
}
