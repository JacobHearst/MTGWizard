//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search for cards", text: $viewModel.name, onCommit: { Task { await viewModel.search() } })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)

                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .onTapGesture { viewModel.showFilters.toggle() }
                }

                Divider()
                    .padding(.top, 2)

                if viewModel.isLoading {
                    ProgressView("Searching...")
                }

                if let err = viewModel.error {
                    Text(String(describing: err))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                }

                CardGrid(cards: viewModel.results)

            }
            .padding()
            .sheet(isPresented: $viewModel.showFilters) {
                SearchFilterView(showFilters: $viewModel.showFilters, filters: $viewModel.filters)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
