//
//  SearchViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/9/21.
//

import Foundation
import ScryfallKit

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results = [Card]()
    @Published var isLoading = false
    @Published var error: Error?

    func search() {
        results = []
        isLoading = true

        ScryfallClient().searchCards(SearchCards(query: query)) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let cards):
                    self.results = cards.data
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
