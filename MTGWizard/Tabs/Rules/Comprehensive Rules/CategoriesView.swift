//
//  CategoriesView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [Category]

    var body: some View {
        List(categories) { category in
            NavigationLink(category.label, value: category)
        }
        .navigationDestination(for: Category.self) { CategoryView(category: $0) }
        .navigationTitle("Categories")
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categories: [])
    }
}
