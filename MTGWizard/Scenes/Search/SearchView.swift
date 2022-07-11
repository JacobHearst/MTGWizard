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
                    TextField("Enter card name", text: $viewModel.name, onCommit: handleSearch)
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
                } else if let err = viewModel.error {
                    Text(String(describing: err))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                } else if viewModel.results.isEmpty {
                    Text("Perform a search to view cards")
                        .padding(.top)
                }

                CardGrid(cards: viewModel.results)

            }
            .navigationBarHidden(true)
            .padding()
            .sheet(isPresented: $viewModel.showFilters) {
                SearchFilterView(showFilters: $viewModel.showFilters, filters: $viewModel.filters)
            }
        }
    }
    
    func handleSearch() {
        Task { await viewModel.search() }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
