//
//  Legality+Color.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI
import ScryfallKit

extension Legality {
    var color: SwiftUI.Color {
        switch self {
        case .legal: return .green
        case .banned: return .red
        case .restricted: return .yellow
        case .notLegal: return .gray
        }
    }
}
