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

    var body: some View {
        List(subcategories) { subcategory in
            NavigationLink(subcategory.label,
                           destination: RulesView(rules: subcategory.rules, subcategoryName: subcategory.title))
        }.navigationTitle(categoryName)
    }
}
