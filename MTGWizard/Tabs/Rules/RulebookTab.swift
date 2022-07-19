//
//  RulesView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct RulebookTab: View {
    @EnvironmentObject var router: Router
    @ObservedObject private var viewModel = RulebookViewModel()

    var body: some View {
        NavigationStack(path: $router.rulebookPath) {
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
                        NavigationLink("Comprehensive Rules", value: rulesObj.rules)
                        NavigationLink("Glossary", value: rulesObj.glossary)
                    } else {
                        Section("Rules (\(viewModel.rulesSearchResults.count))") {
                            ForEach(0..<viewModel.rulesSearchResults.count, id: \.self) { index in
                                viewModel.rulesSearchResults[index]
                            }
                        }

                        Section("Glossary (\(viewModel.glossarySearchResults.count))") {
                            ForEach(0..<viewModel.glossarySearchResults.count, id: \.self) { index in
                                viewModel.rulesSearchResults[index]
                            }
                        }
                    }
                }
                .navigationDestination(for: [Category].self) { CategoriesView(categories: $0) }
                .navigationDestination(for: [GlossaryTerm].self) { GlossaryTermListView(terms: $0) }
                .navigationDestination(for: Rule.self) { RuleView(rule: $0) }
                .navigationDestination(for: GlossaryTerm.self) { GlossaryTermView(term: $0) }
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
        RulebookTab()
    }
}
