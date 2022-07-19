//
//  SubcategoryView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct SubcategoryView: View {
    var subcategory: Subcategory
    
    @State private var filteredRules: [Rule]
    @State private var searchTerm = ""
    
    init(subcategory: Subcategory) {
        self.subcategory = subcategory
        self.filteredRules = subcategory.rules
    }
    
    var body: some View {
        List {
            ForEach(filteredRules) { rule in
                if !rule.subrules.isEmpty {
                    NavigationLink(rule.label, value: rule)
                } else {
                    Text(rule.label)
                }
            }.padding()
        }
        .navigationDestination(for: Rule.self) { RuleView(rule: $0) }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm, perform: onChange)
        .navigationTitle(subcategory.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func onChange(_ term: String) {
        if term.isEmpty {
            filteredRules = subcategory.rules
        } else {
            self.filteredRules = subcategory.rules.filter { rule in
                rule.rule.lowercased().contains(term.lowercased())
            }
        }
    }
}
