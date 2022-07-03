//
//  RaritySelectorView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/2/22.
//

import SwiftUI
import ScryfallKit

struct RaritySelector: View {
    @State private var common = false { didSet { toggle(rarity: .common) }}
    @State private var uncommon = false { didSet { toggle(rarity: .uncommon) }}
    @State private var rare = false { didSet { toggle(rarity: .rare) }}
    @State private var mythic = false { didSet { toggle(rarity: .mythic) }}

    @Binding var selection: [Card.Rarity]

    var body: some View {
        HStack {
            VStack {
                Toggle(isOn: $common) {
                    Text("Common")
                }
                Toggle(isOn: $uncommon) {
                    Text("Uncommon")
                }
            }
            VStack {
                Toggle(isOn: $rare) {
                    Text("Rare")
                }
                Toggle(isOn: $mythic) {
                    Text("Mythic")
                }
            }
        }
    }

    func toggle(rarity: Card.Rarity) {
        if let index = selection.firstIndex(of: rarity) {
            selection.remove(at: index)
        } else {
            selection.append(rarity)
        }
    }
}

struct RaritySelectorView_Previews: PreviewProvider {
    static var previews: some View {
        RaritySelector(selection: .constant([]))
    }
}
