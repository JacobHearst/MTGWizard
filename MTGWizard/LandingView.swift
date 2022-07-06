//
//  ContentView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 5/26/21.
//

import SwiftUI

struct LandingView: View {
    @State private var tab = 0

    var body: some View {
        TabView(selection: $tab) {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(0)
            RulebookView()
                .tabItem {
                    Image(systemName: "text.book.closed")
                    Text("Rulebook")
                }
                .tag(1)
            SavedCardsView()
                .tabItem {
                    Image(systemName: "tray.2.fill")
                    Text("Saved Cards")
                }
                .tag(2)
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
