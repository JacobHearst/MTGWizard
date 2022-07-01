//
//  Rule.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation

struct Category: Codable, Identifiable {
    let id: String
    let title: String
    let subcategories: [Subcategory]

    var label: String {
        "\(id). \(title)"
    }
}

struct Subcategory: Codable, Identifiable {
    let id: String
    let title: String
    let rules: [Rule]

    var label: String {
        "\(id). \(title)"
    }
}

struct Rule: Codable, Identifiable {
    let id: String
    let rule: String
    let subrules: [Subrule]

    var label: String {
        "\(id). \(rule)"
    }
}

struct Subrule: Codable, Identifiable {
    let id: String
    let rule: String

    var label: String {
        "\(id). \(rule)"
    }
}

struct GlossaryTerm: Codable, Identifiable {
    var id: String { term }
    let term: String
    let meanings: [String]
}
