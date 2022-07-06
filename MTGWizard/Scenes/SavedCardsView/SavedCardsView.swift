//
//  SavedCardsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI

struct SavedCardsView: View {
    @ObservedObject private var viewModel = SavedCardsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.error {
                    Text(error)
                } else if viewModel.savedCardNames.isEmpty {
                    Text("No Cards Saved")
                }

                CardGrid(cards: viewModel.cards).navigationTitle("Saved Cards")
            }
            .padding()
            .onAppear {
                viewModel.loadCards()
            }
        }
    }
}

struct SavedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCardsView()
    }
}
