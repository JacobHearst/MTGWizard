//
//  CardDescription.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct CardDescription: View {
    @EnvironmentObject var viewModel: SingleCardViewModel

    var body: some View {
        GroupBox {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.cardName)
                            .font(.headline)
                        Spacer()
                        Spacer()
                        ManaCost(manaCost: viewModel.cardManaCost)
                            .frame(maxHeight: 15)
                    }

                    Text(viewModel.typeLine)
                        .font(.subheadline)
                        .padding(.bottom)

                    Text(viewModel.oracleText ?? "")
                        .padding(.bottom)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(viewModel.cardFlavorText ?? "")
                        .font(.subheadline)
                        .italic()
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
