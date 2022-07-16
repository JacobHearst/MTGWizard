//
//  ColorSelector.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/20/21.
//

import SwiftUI
import ScryfallKit

struct ColorSelector: View, ManaSymbolToggleDelegate {
    @Binding var selectedColors: [ScryfallKit.Color]

    var body: some View {
        HStack(spacing: 20) {
            ManaSymbolToggle(color: .W, delegate: self)
            ManaSymbolToggle(color: .U, delegate: self)
            ManaSymbolToggle(color: .B, delegate: self)
            ManaSymbolToggle(color: .R, delegate: self)
            ManaSymbolToggle(color: .G, delegate: self)
            ManaSymbolToggle(color: .C, delegate: self)
        }
    }

    func didToggle(color: ScryfallKit.Color) {
        if let index = selectedColors.firstIndex(of: color) {
            selectedColors.remove(at: index)
        } else {
            selectedColors.append(color)
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector(selectedColors: .constant([.W]))
    }
}
