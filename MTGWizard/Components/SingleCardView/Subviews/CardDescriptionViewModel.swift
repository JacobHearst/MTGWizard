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
    @Published var isRulesExpanded = false
    @Published var isLegalityExpanded = false
    
    @Published var rulings = [Ruling]()
    @Published var isLoadingRulings = true
    @Published var rulingsError: String?

    init(card: Card) {
        Task {
            do {
                rulings = try await ScryfallClient().getRulings(.scryfallID(id: card.id.uuidString)).data
            } catch {
                rulingsError = "Error loading rulings: \(error)"
            }
            
            isLoadingRulings = false
        }
    }
}
