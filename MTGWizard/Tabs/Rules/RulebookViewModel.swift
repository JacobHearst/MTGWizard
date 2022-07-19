//
//  RulesViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation
import SwiftUI

@MainActor
final class RulebookViewModel: ObservableObject {
    @Published var rulesObj: RulesObject? = nil
    @Published var error: String?
    @Published var searchTermInput: String = "" {
        didSet {
            if searchTermInput.isEmpty {
                self.rulesSearchResults = []
                self.glossarySearchResults = []
            }
        }
    }
    @Published var rulesSearchResults = [NavigationLink<Text, Never>]()
    @Published var glossarySearchResults = [NavigationLink<Text, Never>]()

    init() {
        Task {
            do {
                self.rulesObj = try await getRules()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    func getRules() async throws -> RulesObject {
        let url = URL(string: "https://mtgrulesworker.jhearst5957.workers.dev/v1/rules")!
        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(RulesObject.self, from: data)
    }

    func search() {
        guard let rulesObj = rulesObj else { return }
        self.rulesSearchResults = searchRules(categories: rulesObj.rules, term: searchTermInput)
        self.glossarySearchResults = searchGlossary(glossary: rulesObj.glossary, searchTerm: searchTermInput)
    }

    private func searchRules(categories: [Category], term: String) -> [NavigationLink<Text, Never>] {
        var results = [NavigationLink<Text, Never>]()
        let lowerTerm = term.lowercased()

        for category in categories {
            for subcategory in category.subcategories {
                for rule in subcategory.rules {
                    if rule.rule.lowercased().contains(lowerTerm) {
                        let link = NavigationLink(rule.label, value: rule)
                        results.append(link)
                    }

                    for subrule in rule.subrules {
                        if subrule.rule.lowercased().contains(lowerTerm) {
                            results.append(NavigationLink(subrule.label, value: rule))
                        }
                    }
                }
            }
        }

        return results
    }

    private func searchGlossary(glossary: [GlossaryTerm], searchTerm: String) -> [NavigationLink<Text, Never>] {
        var results = [NavigationLink<Text, Never>]()
        let lowerTerm = searchTerm.lowercased()

        for item in glossary {
            if item.term.lowercased().contains(lowerTerm) {
                results.append(NavigationLink(item.term, value: item))
            }

            for meaning in item.meanings {
                if meaning.lowercased().contains(lowerTerm) {
                    results.append(NavigationLink(meaning, value: item))
                }
            }
        }

        return results
    }
}

struct RulebookSearchResult {
    let title: String
    let link: NavigationLink<Text, Never>
}
