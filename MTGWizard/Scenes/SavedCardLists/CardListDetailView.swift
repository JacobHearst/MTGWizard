//
//  CardListDetailView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/10/22.
//

import SwiftUI

struct CardListDetailView: View {
    var list: CardList

    var body: some View {
        CardGrid(cards: list.cards, activeList: list)
            .padding()
            .navigationTitle(list.name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: SearchView(activeList: list)) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
    }
}

struct CardListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardListDetailView(list: CardList(name: "Test", cards: []))
    }
}
