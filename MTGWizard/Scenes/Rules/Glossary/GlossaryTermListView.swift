//
//  GlossaryTermListView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI

struct GlossaryTermListView: View {
    var terms: [GlossaryTerm]
    @State private var filteredTerms: [GlossaryTerm]
    @State private var searchTerm = ""

    init(terms: [GlossaryTerm]) {
        self.terms = terms
        self.filteredTerms = terms
    }

    var body: some View {
        List(filteredTerms, id: \.term) { term in
            NavigationLink(term.term, destination: GlossaryTermView(term: term))
        }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { term in
            if term.isEmpty {
                filteredTerms = terms
            } else {
                filteredTerms = terms.filter { $0.term.lowercased().contains(term.lowercased()) }
            }
        }
        .navigationTitle("Glossary")
    }
}

struct GlossaryTermListView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryTermListView(terms: [])
    }
}
