//
//  MockData.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import Foundation
import ScryfallKit

struct MockData {
    static let shared = MockData()
    var cards = [Card]()

    init() {
        guard let creatureURLs = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Cards") else {
            print("Failed to get creature URLs")
            return
        }

        for url in creatureURLs {
            if let card = parseCardJSON(url) {
                cards.append(card)
            } else {
                print("Couldn't get card from json. Check logs")
            }
        }
    }

    func parseCardJSON(_ url: URL) -> Card? {
        do {
            guard let jsonData = FileManager.default.contents(atPath: url.path) else {
                print("JSON data was nil")
                return nil
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Card.self, from: jsonData)
        } catch {
            print("Failed to make Card from data: \(error)")
        }

        return nil
    }
}
