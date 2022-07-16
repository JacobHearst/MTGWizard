//
//  RulesView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct RulebookView: View {
    @ObservedObject private var viewModel = RulebookViewModel()

    var body: some View {
        NavigationStack {
            if let error = viewModel.error {
                // Show error
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let rulesObj = viewModel.rulesObj {
                // Show rules
                List {
                    TextField("Search", text: $viewModel.searchTermInput, onCommit: { viewModel.search() })
                        .disableAutocorrection(true)
                        .modifier(ClearButton(text: $viewModel.searchTermInput))
                    if viewModel.rulesSearchResults.isEmpty && viewModel.glossarySearchResults.isEmpty {
                        NavigationLink("Comprehensive Rules", destination: CategoriesView(categories: rulesObj.rules))

                        NavigationLink("Glossary", destination: GlossaryTermListView(terms: rulesObj.glossary))
                    } else {
                        Section("Rules (\(viewModel.rulesSearchResults.count))") {
                            ForEach(viewModel.rulesSearchResults, id: \.title) { result in
                                NavigationLink(result.title, destination: result.destination)
                            }
                        }

                        Section("Glossary (\(viewModel.glossarySearchResults.count))") {
                            ForEach(viewModel.glossarySearchResults, id: \.title) { result in
                                NavigationLink(result.title, destination: result.destination)
                            }
                        }
                    }
                }
                .navigationTitle("Rulebook")

            } else {
                // Show loading
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulebookView()
    }
}
