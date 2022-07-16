//
//  SavedCardsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

struct SavedCardListsView: View {
    @AppStorage("SavedCards") var savedCards = [Card]()

    var body: some View {
        NavigationStack {
            CardGrid(cards: savedCards)
                .navigationTitle("Saved Cards")
                .padding()
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    Button(action: showCreateList) {
//                        Image(systemName: "plus.circle")
//                    }
//                }
//            }
        }
    }
}

struct SavedCardListsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardListsView()
    }
}
