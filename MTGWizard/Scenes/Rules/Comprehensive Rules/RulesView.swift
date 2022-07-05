//
//  RulesListView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct RulesView: View {
    var rules: [Rule]
    var subcategoryName: String

    @State private var filteredRules: [Rule]
    @State private var searchTerm = ""

    init(rules: [Rule], subcategoryName: String) {
        self.rules = rules
        self.subcategoryName = subcategoryName
        self.filteredRules = rules
    }

    var body: some View {
        List(filteredRules) { rule in
            if !rule.subrules.isEmpty {
                NavigationLink(rule.label, destination: RuleView(rule: rule))
                    .padding()
            } else {
                Text(rule.label)
                    .padding()
            }
        }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { term in
            if term.isEmpty {
                filteredRules = rules
            } else {
                self.filteredRules = rules.filter { rule in
                    rule.rule.lowercased().contains(term.lowercased())
                }
            }
        }
        .navigationTitle(subcategoryName)
    }
}
