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
        CardGrid(cards: list.cards)
            .padding()
            .navigationTitle(list.name)
    }
}

struct CardListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardListDetailView(list: CardList(name: "Test", cards: []))
    }
}
