//
//  UserDefaultsService.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import Foundation

// TODO: Convert this to using AppStorage
final class UserDefaultsService {
    private enum Keys {
        static let savedCards = "SavedCards"
    }

    static let shared = UserDefaultsService()
    private let defaults = UserDefaults.standard

    func getSavedCards() -> [String] {
        let cardNames = defaults.array(forKey: Keys.savedCards) as? [String]
        return cardNames ?? []
    }

    func addSavedCard(cardName: String) {
        var cards = getSavedCards()
        cards.append(cardName)
        setSavedCards(cardNames: cards)
    }

    func removeSavedCard(cardName: String) {
        var cards = getSavedCards()
        cards.removeAll { $0 == cardName }
        setSavedCards(cardNames: cards)
    }

    func setSavedCards(cardNames: [String]) {
        defaults.set(cardNames, forKey: Keys.savedCards)
    }
}
