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
    var activeList: CardList? = nil

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter card name", text: $viewModel.name, onCommit: handleSearch)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .modifier(ClearButton(text: $viewModel.name))

                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .onTapGesture { viewModel.showFilters.toggle() }
                }
                
                HStack {
                    Text("Sort by:")
                    Picker("Sort by:", selection: $viewModel.sortMode) {
                        ForEach(SortMode.allCases, id: \.rawValue) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }.pickerStyle(MenuPickerStyle())
                    
                    Spacer()
                    
                    Picker("Sort Direction", selection: $viewModel.sortDirection) {
                        ForEach(SortDirection.allCases, id: \.rawValue) { dir in
                            Text(dir.rawValue.capitalized).tag(dir)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Divider()
                    .padding(.top, 2)

                SearchViewBody(isLoading: viewModel.isLoading,
                               error: viewModel.error,
                               results: viewModel.results,
                               activeList: activeList)

            }
            .navigationBarHidden(true)
            .padding()
            .sheet(isPresented: $viewModel.showFilters) {
                SearchFilterView(showFilters: $viewModel.showFilters, filters: $viewModel.filters)
            }
        }
    }
    
    func handleSearch() {
        viewModel.search()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
