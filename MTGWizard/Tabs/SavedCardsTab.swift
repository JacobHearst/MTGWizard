//
//  SavedCardsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

struct SavedCardsTab: View {
    @AppStorage("SavedCards") var savedCards = [Card]()
    @State private var showSearch = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if savedCards.isEmpty {
                    HStack {
                        Text("Add cards by tapping the ")
                        addCardsButton
                    }
                } else {
                    CardGrid(cards: $savedCards)
                        .padding()
                }
            }
            .navigationTitle("Saved Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbar }
            .sheet(isPresented: $showSearch) {
                NavigationView { SearchView() }
            }
        }
    }
    
    var toolbar: ToolbarItem<(), some View> {
        ToolbarItem(placement: .primaryAction) {
            addCardsButton
        }
    }
    
    var addCardsButton: some View {
        Button(action: { showSearch.toggle() }) {
            Image(systemName: "plus.circle")
        }
    }
}
