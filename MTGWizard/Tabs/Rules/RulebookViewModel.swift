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
    @Published var rulesSearchResults = [RulebookSearchResult<AnyView>]()
    @Published var glossarySearchResults = [RulebookSearchResult<AnyView>]()

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

    private func searchRules(categories: [Category], term: String) -> [RulebookSearchResult<AnyView>] {
        var results = [RulebookSearchResult<AnyView>]()
        let lowerTerm = term.lowercased()

        for category in categories {
            for subcategory in category.subcategories {
                for rule in subcategory.rules {
                    if rule.rule.lowercased().contains(lowerTerm) {
                        let destination = AnyView(RuleView(rule: rule))
                        results.append(RulebookSearchResult(title: rule.label, destination: destination))
                    }

                    for subrule in rule.subrules {
                        if subrule.rule.lowercased().contains(lowerTerm) {
                            let destination = AnyView(RuleView(rule: rule))
                            results.append(RulebookSearchResult(title: subrule.label, destination: destination))
                        }
                    }
                }
            }
        }

        return results
    }

    private func searchGlossary(glossary: [GlossaryTerm], searchTerm: String) -> [RulebookSearchResult<AnyView>] {
        var results = [RulebookSearchResult<AnyView>]()
        let lowerTerm = searchTerm.lowercased()

        for item in glossary {
            if item.term.lowercased().contains(lowerTerm) {
                results.append(RulebookSearchResult(title: item.term, destination: AnyView(Text(item.meanings[0]))))
            }

            for meaning in item.meanings {
                if meaning.lowercased().contains(lowerTerm) {
                    results.append(RulebookSearchResult(title: meaning, destination: AnyView(Text(meaning))))
                }
            }
        }

        return results
    }
}

struct RulebookSearchResult<Destination> where Destination: View {
    let title: String
    let destination: Destination

    var navigationLink: NavigationLink<Text, Destination> {
        NavigationLink(title, destination: destination)
    }
}
