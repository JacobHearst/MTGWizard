//
//  CardDescription.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct CardDescription: View {
    @ObservedObject private var viewModel: CardDescriptionViewModel
    @State private var isRulesExpanded = false
    @State private var isLegalityExpanded = false
    @State private var isPricesExpanded = true
    @State private var isTextExpanded = true

    @Binding var card: Card
    var viewingSecondFace: Bool
    
    init(card: Binding<Card>, viewingSecondFace: Bool) {
        self._card = card
        self.viewingSecondFace = viewingSecondFace
        self.viewModel = CardDescriptionViewModel(card: card.wrappedValue)
    }
    
    var body: some View {
        GroupBox {
            ScrollView {
                VStack(alignment: .leading) {
                    DisclosureGroup("Card Text", isExpanded: $isTextExpanded) { CardText(card: card, viewingSecondFace: viewingSecondFace) }
                    DisclosureGroup("Pricing", isExpanded: $isPricesExpanded) { priceContent }
                    DisclosureGroup("Rulings", isExpanded: $isRulesExpanded) { rulingsContent }
                    DisclosureGroup("Legality", isExpanded: $isLegalityExpanded) { LegalityView(card: card) }
                }
            }
        }
    }
    
    var rulingsContent: some View {
        if viewModel.isLoadingRulings {
            return AnyView(ProgressView())
        } else {
            return AnyView(RulingsList(rulings: viewModel.rulings))
        }
    }
    
    var priceContent: some View {
        if viewModel.isLoadingRulings {
            return AnyView(ProgressView())
        } else {
            return AnyView(CardPriceView(selectedPrinting: $card, printings: viewModel.printings))
        }
    }
}
