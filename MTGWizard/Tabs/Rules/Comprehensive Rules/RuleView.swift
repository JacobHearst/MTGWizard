//
//  RuleView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct RuleView: View {
    var rule: Rule

    var body: some View {
        VStack {
            Text(rule.label)
                .padding()
                .font(.headline)

            List(rule.subrules) { subrule in
                Text(subrule.label)
            }

        }
        .navigationTitle(rule.id)
        .navigationBarTitleDisplayMode(.inline)
    }
}
