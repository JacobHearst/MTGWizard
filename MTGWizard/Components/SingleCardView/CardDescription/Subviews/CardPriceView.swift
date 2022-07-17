//
//  CardPriceView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/16/22.
//

import SwiftUI
import ScryfallKit

struct CardPriceView: View {
    @Binding var selectedPrinting: Card
    var printings: [Card]
    
    var sortedPrintings: [Card] {
        var sortedPrintings = printings.sorted { $0.set < $1.set }

        sortedPrintings.removeAll { $0 == selectedPrinting }
        sortedPrintings.insert(selectedPrinting, at: 0)

        return sortedPrintings
    }

    var body: some View {
        Grid {
            GridRow {
                Image(systemName: "eye.fill")
                Text("#")
                Text("Set")
                Text("USD")
                Text("EUR")
                Text("TIX")
            }.bold()
            Divider()
            ForEach(sortedPrintings) { printing in
                GridRow {
                    Image(systemName: imageName(for: printing))
                    Text(printing.collectorNumber)
                    Text(printing.set.uppercased())
                    Text(printing.prices.usd ?? "N/A")
                    Text(printing.prices.eur ?? "N/A")
                    Text(printing.prices.tix ?? "N/A")
                }
                .onTapGesture { selectedPrinting = printing }
                Divider()
            }
        }
    }
    
    func imageName(for printing: Card) -> String {
        printing == selectedPrinting ? "circle.fill" : "circle"
    }
}
