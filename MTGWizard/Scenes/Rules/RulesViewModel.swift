//
//  RulesViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/1/22.
//

import Foundation

@MainActor
final class RulesViewModel: ObservableObject {
    @Published var rules = [Category]()
    @Published var error: String?
    @Published var glossary = [GlossaryTerm]()

    init() {
        Task {
            do {
                rules = try await getRules()
                glossary = try await getGlossary()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    func getRules() async throws -> [Category] {
        let url = URL(string: "https://hearst.dev/mtg/rules")!
        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode([Category].self, from: data)
    }

    func getGlossary() async throws -> [GlossaryTerm] {
        let url = URL(string: "https://hearst.dev/mtg/rules/glossary")!
        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode([GlossaryTerm].self, from: data)
    }
}
