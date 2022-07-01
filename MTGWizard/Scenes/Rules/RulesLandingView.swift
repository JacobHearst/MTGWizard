//
//  RulesView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct RulesLandingView: View {
    @StateObject private var viewModel = RulesViewModel()

    var body: some View {
        NavigationView {
            if let error = viewModel.error {
                // Show error
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if viewModel.rules.isEmpty {
                // Show loading
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                // Show rules
                List(viewModel.rules) { category in
                    NavigationLink(category.label,
                                   destination: SubcategoriesView(subcategories: category.subcategories,categoryName: category.title)
                    )
                }.navigationTitle("Comprehensive Rules")
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesLandingView()
    }
}
