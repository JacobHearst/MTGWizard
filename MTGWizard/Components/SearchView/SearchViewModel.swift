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
    @AppStorage("UseQuerySearch") var useQuerySearch = false
    
    @Published var searchText = ""
    @Published var results = [Card]()
    @Published var isLoading = false
    @Published var error: Error?
    @Published var filters = SearchFilters()
    @Published var sortMode: SortMode = .name { didSet { Task { await search() }}}
    @Published var sortDirection: SortDirection = .auto { didSet { Task { await search() }}}
    @Published var showFilters = true {
        didSet {
            guard !showFilters else { return }
            Task { await search() }
        }
    }
    
    let defaultQuery = "mana=4gg o:trample pow:6 tou:6"
    let defaultName = "Teferi"
    var searchPlaceholder: String {
        useQuerySearch ? defaultQuery : defaultName
    }

    init() {
        Task { await search() }
    }
    
    // MARK: Search
    func search() async {
        useQuerySearch ? await querySearch() : await filterSearch()
    }
    
    func querySearch() async {
        resetSearchStatus()

        var query = searchText.isEmpty && filters.scryfallKitFilters.isEmpty ? defaultQuery : searchText
        if hideAlchemy {
            query += " -format:Alchemy"
        }
        
        do {
            results = try await client.searchCards(query: query, order: sortMode, sortDirection: sortDirection).data
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func filterSearch() async {
        let searchValue = searchText.isEmpty && filters.scryfallKitFilters.isEmpty ? defaultName : searchText
        var searchFilters = filters.scryfallKitFilters + [.name(searchValue)]
        guard searchFilters.count > 0 else { return }
        
        if hideAlchemy {
            // FIXME: ScryfallKit needs an update to support negating filters. This should do the trick for now
            searchFilters += [.game(.paper), .game(.mtgo)]
        }
        
        resetSearchStatus()

        do {
            results = try await client.searchCards(filters: searchFilters, order: sortMode, sortDirection: sortDirection).data
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
