//
//  Card+Equatable.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/10/22.
//

import ScryfallKit

extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
}
