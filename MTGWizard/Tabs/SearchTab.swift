//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI

struct SearchTab: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationBarHidden(true)
        }
    }
}

struct SearchViewTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchTab()
    }
}
