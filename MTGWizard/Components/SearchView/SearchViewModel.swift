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
    @AppStorage("HideAlchemy") var hideAlchemy = false
    @Published var name = ""
    @Published var results = [Card]()
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showFilters = false {
        didSet {
            guard !showFilters else { return }
            search()
        }
    }
    @Published var filters = SearchFilters()
    @Published var sortMode: SortMode = .name { didSet { search() }}
    @Published var sortDirection: SortDirection = .auto { didSet { search() }}

    init() {
        search()
    }

    func search() {
        var searchFilters = filters.scryfallKitFilters + [.name(name)]
        guard searchFilters.count > 0 else { return }
        
        if hideAlchemy {
            // FIXME: ScryfallKit needs an update to support negating filters. This should do the trick for now
            searchFilters += [.game(.paper), .game(.mtgo)]
        }

        // Clear previous results/errors and show loading indicator
        results = []
        error = nil
        isLoading = true

        Task {
            do {
                results = try await ScryfallClient().searchCards(filters: searchFilters, order: sortMode, sortDirection: sortDirection).data
            } catch {
                self.error = error
            }
            
            isLoading = false
        }
    }
}
