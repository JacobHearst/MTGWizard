//
//  ManaSymbolToggle.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/2/22.
//

import SwiftUI
import ScryfallKit

protocol ManaSymbolToggleDelegate {
    func didToggle(color: ScryfallKit.Color) -> Void
}

struct ManaSymbolToggle: View {
    let color: ScryfallKit.Color
    let delegate: ManaSymbolToggleDelegate
    @State var selected = false

    var body: some View {
        Image("{\(color.rawValue)}")
            .resizable()
            .frame(width: 40, height: 40)
            .onTapGesture {
                selected.toggle()
                delegate.didToggle(color: color)
            }
            .opacity(selected ? 1 : 0.5)
    }
}

struct ManaSymbolToggle_Previews: PreviewProvider, ManaSymbolToggleDelegate {
    func didToggle(color: ScryfallKit.Color) {}

    static var previews: some View {
        ManaSymbolToggle(color: .B, delegate: ManaSymbolToggle_Previews())
    }
}
