//
//  RaritySelectorView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/2/22.
//

import SwiftUI
import ScryfallKit

struct RaritySelector: View {
    @State private var common = false
    @State private var uncommon = false
    @State private var rare = false
    @State private var mythic = false

    @Binding var selection: [Card.Rarity]

    var body: some View {
        HStack {
            VStack {
                Toggle(isOn: $common) {
                    Text("Common")
                }.onTapGesture { toggle(rarity: .common) }
                Toggle(isOn: $uncommon) {
                    Text("Uncommon")
                }.onTapGesture { toggle(rarity: .uncommon) }
            }
            VStack {
                Toggle(isOn: $rare) {
                    Text("Rare")
                }.onTapGesture { toggle(rarity: .rare) }
                Toggle(isOn: $mythic) {
                    Text("Mythic")
                }.onTapGesture { toggle(rarity: .mythic) }
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
