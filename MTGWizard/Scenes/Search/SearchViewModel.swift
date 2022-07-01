//
//  SearchViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/9/21.
//

import Foundation
import ScryfallKit

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var name = "Dusk // Dawn"
    @Published var results = [Card]()
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isFiltersShown = false
    @Published var filters = SearchFilters() {
        didSet {
            Task { await search() }
        }
    }

    init() {
        Task { await search() }
    }

    func syncSearch() {
        Task { await search() }
    }

    func search() async {
        var searchFilters = filters.scryfallKitFilters
        if !name.isEmpty {
            searchFilters.append(.name(name))
        }

        guard searchFilters.count > 0 else { return }

        // Clear previous results/errors and show loading indicator
        results = []
        error = nil
        isLoading = true

        do {
            results = try await ScryfallClient().searchCards(filters: searchFilters).data
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
