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

    var body: some View {
        List(rules) { rule in
            if !rule.subrules.isEmpty {
                NavigationLink(rule.label, destination: RuleView(rule: rule))
                    .padding()
            } else {
                Text(rule.label)
                    .padding()
            }
        }.navigationTitle(subcategoryName)
    }
}
