//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI

struct SearchTab: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationStack(path: $router.searchPath) {
            SearchView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Search")
        }
    }
}

struct SearchViewTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchTab()
    }
}
