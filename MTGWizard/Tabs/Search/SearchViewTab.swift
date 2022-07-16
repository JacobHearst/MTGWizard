//
//  SearchView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI

struct SearchViewTab: View {
    var activeList: CardList? = nil

    var body: some View {
        NavigationStack {
            SearchView(activeList: activeList)
                .navigationBarHidden(true)
        }
    }
}

struct SearchViewTab_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewTab()
    }
}
