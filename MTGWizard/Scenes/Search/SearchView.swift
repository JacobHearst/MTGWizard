//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel

    init() {
        _viewModel = StateObject(wrappedValue: SearchViewModel())
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Perform a Scryfall search", text: $viewModel.query, onCommit: { viewModel.search() })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action: viewModel.search) {
                        Text("Search")
                    }
                }

                if viewModel.isLoading {
                    ProgressView("Searching...")
                }

                if let err = viewModel.error {
                    Text(String(describing: err))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                }

                CardGrid(cards: viewModel.results)

            }.padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
