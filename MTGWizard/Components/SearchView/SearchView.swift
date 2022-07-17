//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/11/22.
//

import SwiftUI
import ScryfallKit

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            HStack {
                TextField("mana=4gg o:trample pow:6 tou:6", text: $viewModel.searchText, onCommit: handleSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .modifier(ClearButton(text: $viewModel.searchText))

                Image(systemName: "line.horizontal.3.decrease.circle")
                    .onTapGesture { viewModel.showFilters.toggle() }
                    .foregroundColor(.blue)
            }
            
            CardSortControls(sortMode: $viewModel.sortMode, sortDir: $viewModel.sortDirection)

            Divider()
                .padding(.top, 2)

            SearchViewBody(isLoading: viewModel.isLoading,
                           error: viewModel.error,
                           results: viewModel.results)

        }
        .padding()
        .toolbar(.hidden)
        .sheet(isPresented: $viewModel.showFilters) {
            SearchFilterView(showFilters: $viewModel.showFilters, filters: $viewModel.filters)
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
