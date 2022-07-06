//
//  SavedCardsViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import Foundation
import ScryfallKit
import SwiftUI

@MainActor
final class SavedCardsViewModel: ObservableObject {
    @Published var savedCardNames = [String]()
    @Published var cards = [Card]()
    @Published var error: String?

    func loadCards() {
        savedCardNames = UserDefaultsService.shared.getSavedCards()
        guard !savedCardNames.isEmpty else { return }

        let identifiers = savedCardNames.map { Card.CollectionIdentifier.name($0) }

        Task {
            do {
                let collection = try await ScryfallClient().getCardCollection(identifiers: identifiers)
                cards = collection.data
            } catch {
                print(error)
            }
        }
    }
}
