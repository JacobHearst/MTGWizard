//
//  CardGrid.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct CardGrid: View {
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: 2)
    }

    @Binding var cards: [Card]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach($cards, content: imageLink)
                }
            }
        }
    }
    
    func imageLink(card: Binding<Card>) -> some View {
        let unwrapped = card.wrappedValue
        return NavigationLink(destination: SingleCardView(card: card, printing: unwrapped)) {
            if let url = unwrapped.getImageURL(types: [.png, .normal]) {
                AsyncImage(url: url, content: { image in
                    image.resizable()
                         .scaledToFit()
                }) {
                    VStack {
                        Text(unwrapped.name)
                        ProgressView()
                    }
                }
            } else {
                Text("No image for \(unwrapped.name)")
            }
        }
    }
}

struct CardGrid_Previews: PreviewProvider {
    static var previews: some View {
        CardGrid(cards: .constant([]))
    }
}
