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
    var card: Card
    var viewingSecondFace: Bool
    
    init(card: Card, viewingSecondFace: Bool) {
        self.card = card
        self.viewingSecondFace = viewingSecondFace
        self.viewModel = CardDescriptionViewModel(card: card)
    }
    
    var body: some View {
        GroupBox {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(cardName)
                            .font(.headline)
                        Spacer()
                        Spacer()
                        ManaCostView(manaCost: cardManaCost)
                            .frame(maxHeight: 15)
                    }
                    
                    Text(typeLine ?? "No Types")
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    Text(oracleText ?? "No oracle text")
                        .padding(.bottom)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(1)
                    
                    Text(cardFlavorText ?? "No flavor text")
                        .font(.subheadline)
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    DisclosureGroup("Rulings", isExpanded: $viewModel.isRulesExpanded) {
                        if viewModel.isLoadingRulings {
                            ProgressView()
                        } else {
                            RulingsList(rulings: viewModel.rulings)
                        }
                    }
                    
                    DisclosureGroup("Legality", isExpanded: $viewModel.isLegalityExpanded) {
                        LegalityView(card: card)
                    }
                }
            }
        }
    }
    
    var cardFlavorText: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.flavorText, useSecondFace: viewingSecondFace) : card.flavorText
    }
    
    var cardManaCost: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.manaCost, useSecondFace: viewingSecondFace) : card.manaCost
    }
    
    var cardName: String {
        (try? card.getAttributeForFace(keyPath: \.name, useSecondFace: viewingSecondFace)) ?? card.name
    }
    
    var oracleText: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.oracleText, useSecondFace: viewingSecondFace) : card.oracleText
    }
    
    var typeLine: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.typeLine, useSecondFace: viewingSecondFace) : card.typeLine
    }
}
