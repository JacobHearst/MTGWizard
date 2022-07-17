//
//  SearchViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/9/21.
//

import Foundation
import ScryfallKit
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    private var client = ScryfallClient()

    @AppStorage("HideAlchemy") var hideAlchemy = false
    
    @Published var searchText = ""
    @Published var results = [Card]()
    @Published var isLoading = false
    @Published var error: Error?
    @Published var filters = SearchFilters()
    @Published var sortMode: SortMode = .name { didSet { Task { await search() }}}
    @Published var sortDirection: SortDirection = .auto { didSet { Task { await search() }}}
    @Published var showFilters = false {
        didSet {
            guard !showFilters else { return }
            Task { await search() }
        }
    }

    init() {
        Task { await search() }
    }
    
    // MARK: Search
    func search() async {
        resetSearchStatus()

        // Unless search parameters were provided
        guard !searchText.isEmpty || !filters.scryfallKitFilters.isEmpty else {
            // Exit
            isLoading = false
            return
        }
        
        // Otherwise, use them to make the base query
        let filterString = filters.scryfallKitFilters
            .map { $0.filterString }
            .joined(separator: " ")

        var query = "\(searchText) \(filterString)"

        if hideAlchemy {
            query += " (game:paper or game:mtgo)"
        }
        
        do {
            results = try await client.searchCards(query: query, order: sortMode, sortDirection: sortDirection).data
        } catch {
            self.error = error
        }
        
        isLoading = false
    }

    /// Clear previous results/errors and show loading indicator
    func resetSearchStatus() {
        results = []
        error = nil
        isLoading = true
    }
}
