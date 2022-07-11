//
//  ContentView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 5/26/21.
//

import SwiftUI

struct LandingView: View {
    enum TabSelection {
        case search, saved, rules
    }
    
    @State private var tab: TabSelection = .saved

    var body: some View {
        TabView(selection: $tab) {
            SearchViewTab()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(TabSelection.search)
            SavedCardListsView()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Saved Cards")
                }
                .tag(TabSelection.saved)
            RulebookView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Rulebook")
                }
                .tag(TabSelection.rules)
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
