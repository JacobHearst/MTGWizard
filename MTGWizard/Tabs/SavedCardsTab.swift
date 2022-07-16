//
//  SavedCardsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

struct SavedCardsTab: View {
    @AppStorage("SavedCards") var savedCards = [Card]()
    
    var body: some View {
        NavigationStack {
            VStack {
                if savedCards.isEmpty {
                    HStack {
                        Text("Add cards by tapping the ")
                        addCardsLink
                    }
                } else {
                    CardGrid(cards: savedCards)
                        .padding()
                }
            }
            .navigationTitle("Saved Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addCardsLink
                }
            }
        }
    }
    
    var addCardsLink: some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "plus.circle")
        }
    }
}
