//
//  Card.Rarity+label.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import ScryfallKit

extension Card.Rarity {
    var label: String {
        let firstLetter = rawValue.prefix(1).uppercased()
        let restOfTheWord = rawValue.suffix(rawValue.count - 1)
        return "\(firstLetter)\(restOfTheWord)"
    }
}
