//
//  MultiToggleView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/19/22.
//

import SwiftUI
import ScryfallKit

struct MultiToggleView<OptionType>: View where OptionType: Hashable & StringRepresentable {
    @Binding var selection: [OptionType]

    var options: [OptionType]
    var columnCount: Int = 3
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible()), count: columnCount)
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(options, id: \.self) { option in
                makeOption(option: option)
            }
        }
    }
    
    func makeOption(option: OptionType) -> some View {
        Button(action: { toggleOption(option) }) {
            Text(option.stringRep.capitalized)
                .dynamicTypeSize(.xSmall)
        }
        .buttonStyle(BorderedButtonStyle())
        .opacity(selection.contains(option) ? 1 : 0.5)
    }
    
    func toggleOption(_ option: OptionType) {
        if selection.contains(option) {
            selection.removeAll { $0 == option }
        } else {
            selection.append(option)
        }
    }
}

struct MultiToggleView_Previews: PreviewProvider {
    static var previews: some View {
        MultiToggleView<BorderColor>(
            selection: .constant(BorderColor.allCases),
            options: BorderColor.allCases
        )
    }
}
