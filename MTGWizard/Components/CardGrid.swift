//
//  CardGrid.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit
import CachedAsyncImage

struct CardGrid: View {
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }

    @Binding var cards: [Card]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach($cards) { card in
                        NavigationLink(destination: SingleCardView(card: card, printing: card.wrappedValue)) {
                            CardImage(card: card.wrappedValue)
                        }
                    }
                }
            }
        }
    }
}

struct CardGrid_Previews: PreviewProvider {
    static var previews: some View {
        CardGrid(cards: .constant([]))
    }
}
