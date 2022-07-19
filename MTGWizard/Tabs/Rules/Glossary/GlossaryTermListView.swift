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
            NavigationLink(term.term, value: term)
        }
        .navigationDestination(for: GlossaryTerm.self) { GlossaryTermView(term: $0) }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm, perform: onChange)
        .navigationTitle("Glossary")
    }
    
    func onChange(_ term: String) {
        if term.isEmpty {
            filteredTerms = terms
        } else {
            filteredTerms = terms.filter { $0.term.lowercased().contains(term.lowercased()) }
        }
    }
}

struct GlossaryTermListView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryTermListView(terms: [])
    }
}
