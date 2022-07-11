//
//  LegalityView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

struct LegalityView: View {
    let card: Card

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Format.allCases, id: \.rawValue) { format in
                HStack {
                    Text("\(format.rawValue.capitalized):")
                    Spacer()
                    let legality = card.getLegality(for: format)
                    Text(legality.label)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom], 3)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .foregroundColor(legality.color)
                        )
                }.padding(.bottom, 3)
            }
        }
    }
}
