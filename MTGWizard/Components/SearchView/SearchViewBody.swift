//
//  SearchViewBody.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/10/22.
//

import SwiftUI
import ScryfallKit

struct SearchViewBody: View {
    var isLoading: Bool
    var error: Error?
    var results: [Card]
    
    var body: some View {
        if isLoading {
            ProgressView("Searching...")
        } else if let err = error {
            Text(String(describing: err))
                .padding(.top)
                .multilineTextAlignment(.center)
        } else if results.isEmpty {
            Text("Perform a search to view cards")
                .padding(.top)
        }
        
        CardGrid(cards: .constant(results))
    }
}

struct SearchViewBody_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewBody(isLoading: false, results: [])
    }
}
