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
            SearchTab()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(TabSelection.search)
            SavedCardsTab()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Saved Cards")
                }
                .tag(TabSelection.saved)
            RulebookTab()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Rulebook")
                }
                .tag(TabSelection.rules)
            SettingsTab()
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
