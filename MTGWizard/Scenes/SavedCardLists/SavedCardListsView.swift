//
//  SavedCardsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

struct SavedCardListsView: View {
    @AppStorage("CardLists") var cardLists = [CardList]()
    @AppStorage("SavedCards") var savedCards = [Card]()
    
    var savedCardsList: CardList {
        CardList(name: "Saved", cards: savedCards)
    }

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Saved", destination: CardListDetailView(list: savedCardsList))
                ForEach(cardLists) { list in
                    NavigationLink(list.name, destination: CardListDetailView(list: list))
                }
            }.navigationTitle("Your Lists")
        }
    }
}

struct SavedCardListsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardListsView()
    }
}
