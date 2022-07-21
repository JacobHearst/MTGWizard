//
//  StringRepresentable.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/19/22.
//

import Foundation
import ScryfallKit

protocol StringRepresentable {
    var stringRep: String { get }
}

extension Card.Rarity: StringRepresentable {
    var stringRep: String { rawValue }
}

extension BorderColor: StringRepresentable {
    var stringRep: String { rawValue }
}
