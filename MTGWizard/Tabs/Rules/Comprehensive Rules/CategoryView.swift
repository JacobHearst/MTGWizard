//
//  CategoryView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import SwiftUI

struct CategoryView: View {
    var category: Category

    @State var filteredSubcategories: [Subcategory]
    @State var searchTerm = ""

    init(category: Category) {
        self.category = category
        self.filteredSubcategories = category.subcategories
    }

    var body: some View {
        List(filteredSubcategories) { subcategory in
            NavigationLink(subcategory.label, value: subcategory)
        }
        .navigationDestination(for: Subcategory.self) { SubcategoryView(subcategory: $0) }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm, perform: onChange)
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func onChange(_ term: String) {
        if term.isEmpty {
            filteredSubcategories = category.subcategories
        } else {
            self.filteredSubcategories = category.subcategories.filter { $0.title.lowercased().contains(term.lowercased()) }
        }
    }
}
