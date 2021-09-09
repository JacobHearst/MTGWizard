//
//  CardGrid.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct CardGrid: View {
    var cards: [Card]

    private var columns: [GridItem] = Array(
        repeating: .init(.flexible()),
        count: 2
    )

    init(cards: [Card]) {
        self.cards = cards
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(cards) { card in
                    NavigationLink(destination: SingleCardView(card: card)) {
                        if let url = card.getImageURL(type: .normal) {
                            AsyncImage(url: url)
                        } else {
                            Text("No image for \(card.name)")
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct CardGrid_Previews: PreviewProvider {
    static var previews: some View {
        CardGrid(cards: [])
    }
}
