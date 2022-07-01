//
//  SearchFilterViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/16/21.
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
    var oracleText: String = ""
    var typeLine: String = ""
    var colors: ColorSelection = ColorSelection()
    var colorFilterOption: ColorFilterOption = .exact
    var colorIdentity: ColorSelection = ColorSelection()
    var manaCost: String = ""
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

        if !colors.selection.isEmpty {
            let colorString = colors.selection
                .map { $0.rawValue }
                .joined(separator: "")
            filters.append(.colors(colorString, colorFilterOption.comparison))
        }

        if !colorIdentity.selection.isEmpty {
            let colorIdentityString = colorIdentity.selection
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

enum Currency: String {
    case USD, EUR, TIX
}

final class SearchFilterViewModel: ObservableObject {
    @Published var rulesText: String = ""
    @Published var typeLine: String = ""
    @Published var colors = ColorSelection()
    @Published var colorFilterSelection: ColorFilterOption = .exact
    @Published var colorIdentity = ColorSelection()
    @Published var manaCost: String = ""

    @Published var common: Bool = false
    @Published var uncommon: Bool = false
    @Published var rare: Bool = false
    @Published var mythic: Bool = false

    @Published var priceFilterCurrency: Currency = .USD
    @Published var priceComparisionType: ComparisonType = .lessThan

    init() {}

    init(from searchFilters: SearchFilters) {
        rulesText = searchFilters.oracleText
        typeLine = searchFilters.typeLine
        colors = searchFilters.colors
        colorFilterSelection = searchFilters.colorFilterOption
        colorIdentity = searchFilters.colorIdentity
        manaCost = searchFilters.manaCost
        common = searchFilters.rarities.contains(.common)
        uncommon = searchFilters.rarities.contains(.uncommon)
        rare = searchFilters.rarities.contains(.rare)
        mythic = searchFilters.rarities.contains(.mythic)
    }

    var filters: SearchFilters {
        var rarities = [Card.Rarity]()
        if common { rarities.append(.common) }
        if uncommon { rarities.append(.uncommon) }
        if rare { rarities.append(.rare) }
        if mythic { rarities.append(.mythic) }

        return SearchFilters(
            oracleText: rulesText,
            typeLine: typeLine,
            colors: colors,
            colorFilterOption: colorFilterSelection,
            colorIdentity: colorIdentity,
            manaCost: manaCost,
            rarities: rarities
        )
    }
}

extension Card.Rarity {
    var label: String {
        let firstLetter = rawValue.prefix(1).uppercased()
        let restOfTheWord = rawValue.suffix(rawValue.count - 1)
        return "\(firstLetter)\(restOfTheWord)"
    }
}
