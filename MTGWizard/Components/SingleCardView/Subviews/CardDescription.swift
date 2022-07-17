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
                    
                    if let power = power, let toughness = toughness {
                        Divider()
                        HStack {
                            Spacer()
                            Text("\(power)/\(toughness)")
                        }
                        Divider()
                    }
                    
                    DisclosureGroup("Pricing", isExpanded: $isPricesExpanded) {
                        if viewModel.isLoadingPrintings {
                            ProgressView()
                        } else {
                            CardPriceView(selectedPrinting: $card, printings: viewModel.printings)
                        }
                    }
                    
                    DisclosureGroup("Rulings", isExpanded: $isRulesExpanded) {
                        if viewModel.isLoadingRulings {
                            ProgressView()
                        } else {
                            RulingsList(rulings: viewModel.rulings)
                        }
                    }
                    
                    DisclosureGroup("Legality", isExpanded: $isLegalityExpanded) {
                        LegalityView(card: card)
                    }
                }
            }
        }
    }
    
    var power: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.power, useSecondFace: viewingSecondFace) : card.power
    }
    
    var toughness: String? {
        card.cardFaces != nil ? try? card.getAttributeForFace(keyPath: \.toughness, useSecondFace: viewingSecondFace) : card.toughness
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
