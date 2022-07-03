//
//  SearchFilters.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation
import ScryfallKit

enum ColorFilterOption: String, CaseIterable {
    case exact, including, atMost

    var label: String {
        switch self {
        case .exact:
            return "Are exactly these colors"
        case .including:
            return "Include these colors"
        case .atMost:
            return "Are at most these colors"
        }
    }

    var comparison: ComparisonType {
        switch self {
        case .exact:
            return .equal
        case .including:
            return .including
        case .atMost:
            return .lessThanOrEqual
        }
    }
}

struct SearchFilters {
    var oracleText = ""
    var typeLine = ""
    var colors = [ScryfallKit.Color]()
    var colorFilterOption: ColorFilterOption = .exact
    var colorIdentity = [ScryfallKit.Color]()
    var manaCost = ""
    var rarities = [Card.Rarity]()

    var scryfallKitFilters: [CardFieldFilter] {
        var filters = [CardFieldFilter]()

        if !oracleText.isEmpty {
            filters.append(.oracleText(oracleText))
        }

        if !typeLine.isEmpty {
            typeLine.split(separator: " ").forEach { type in
                filters.append(.type(String(type)))
            }
        }

        if !colors.isEmpty {
            let colorString = colors
                .map { $0.rawValue }
                .joined(separator: "")
            filters.append(.colors(colorString, colorFilterOption.comparison))
        }

        if !colorIdentity.isEmpty {
            let colorIdentityString = colorIdentity
                .map { $0.rawValue }
                .joined(separator: "")
            filters.append(.colorIdentity(colorIdentityString))
        }

        if !manaCost.isEmpty {
            filters.append(.mana(manaCost))
        }

        let rarityFilters: [CardFieldFilter] = rarities.map { .rarity($0.rawValue) }
        if !rarityFilters.isEmpty {
            filters.append(.compoundOr(rarityFilters))
        }

        return filters
    }
}
