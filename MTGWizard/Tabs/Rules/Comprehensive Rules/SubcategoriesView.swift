//
//  SubcategoryView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct SubcategoriesView: View {
    var subcategories: [Subcategory]
    var categoryName: String

    @State var filteredSubcategories: [Subcategory]
    @State var searchTerm = ""

    init(subcategories: [Subcategory], categoryName: String) {
        self.subcategories = subcategories
        self.filteredSubcategories = subcategories
        self.categoryName = categoryName
    }

    var body: some View {
        List(filteredSubcategories) { subcategory in
            NavigationLink(subcategory.label,
                           destination: RulesView(rules: subcategory.rules, subcategoryName: subcategory.title))
        }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { term in
            if term.isEmpty {
                filteredSubcategories = subcategories
            } else {
                self.filteredSubcategories = subcategories.filter { $0.title.lowercased().contains(term.lowercased()) }
            }
        }
        .navigationTitle(categoryName)
    }
}
