//
//  Legality+Label.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import ScryfallKit

extension Legality {
    var label: String {
        switch self {
        case .legal:
            return "Legal"
        case .restricted:
            return "Restricted"
        case .banned:
            return "Banned"
        case .notLegal:
            return "Not Legal"
        }
    }
}
