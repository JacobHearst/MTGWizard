//
//  ContentView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 5/26/21.
//

import SwiftUI

struct LandingView: View {
    enum TabSelection {
        case search, saved, rules, settings
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
            SavedCardsView()
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
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(TabSelection.settings)
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
