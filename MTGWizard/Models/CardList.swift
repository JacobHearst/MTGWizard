//
//  CardList.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/10/22.
//

import Foundation
import ScryfallKit

struct CardList: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var cards: [Card]
    
    static func == (lhs: CardList, rhs: CardList) -> Bool {
        lhs.id == rhs.id
    }
}
