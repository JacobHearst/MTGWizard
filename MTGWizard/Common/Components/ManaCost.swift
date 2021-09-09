//
//  ManaCost.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct ManaCost: View {
    var manaCostSymbols: [String]

    init(manaCost: String?) {
        guard let cost = manaCost else {
            self.manaCostSymbols = []
            return
        }

        manaCostSymbols = cost
            .split(separator: "{")
            .map { "{\($0)" }
    }

    var body: some View {
        HStack(spacing: 2) {
            ForEach(manaCostSymbols, id: \.self) { symbol in
                Image(symbol)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

struct ManaCost_Previews: PreviewProvider {
    static var previews: some View {
        ManaCost(manaCost: "{W}{U}{R}")
    }
}
