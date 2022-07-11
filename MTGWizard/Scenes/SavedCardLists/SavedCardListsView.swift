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
                        .swipeActions {
                            Button(role: .destructive, action: { deleteList(list) }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Your Lists")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: showCreateList) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
    
    func showCreateList() {
        presentTextFieldAlert(title: "Create List",
                              message: "Create a new list",
                              hintText: "List name",
                              primaryActionTitle: "Create",
                              secondaryActionTitle: "Cancel",
                              primaryAction: { cardLists.append(CardList(name: $0, cards: [])) },
                              secondaryAction: {})
    }
    
    func deleteList(_ list: CardList) {
        cardLists.removeAll { $0 == list }
    }
}

struct SavedCardListsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardListsView()
    }
}
