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
            ForEach(printings) { printing in
                GridRow {
                    Image(systemName: printing == selectedPrinting ? "circle.fill" : "circle")
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
}
