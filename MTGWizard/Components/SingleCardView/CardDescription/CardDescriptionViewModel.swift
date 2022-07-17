//
//  CardDescriptionViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/10/22.
//

import Foundation
import ScryfallKit

@MainActor
final class CardDescriptionViewModel: ObservableObject {
    @Published var rulings = [Ruling]()
    @Published var isLoadingRulings = true
    @Published var rulingsError: String?
    
    @Published var printings = [Card]()
    @Published var isLoadingPrintings = true
    @Published var printingsError: String?

    init(card: Card) {
        Task {
            await loadRulings(for: card)
            await loadPrintings(for: card)
        }
    }
    
    func loadRulings(for card: Card) async {
        rulingsError = nil
        isLoadingRulings = false
        
        do {
            rulings = try await ScryfallClient().getRulings(.scryfallID(id: card.id.uuidString)).data
        } catch {
            rulingsError = "Error loading rulings: \(error)"
        }
        
        isLoadingRulings = false
    }
    
    func loadPrintings(for card: Card) async {
        printingsError = nil
        isLoadingPrintings = true

        do {
            printings = try await ScryfallClient().searchCards(filters: [.name(card.name)], unique: .prints).data
        } catch {
            printingsError = error.localizedDescription
        }
        
        isLoadingPrintings = false
    }
}
