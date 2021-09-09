//
//  CardDescriptionViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

final class SingleCardViewModel: ObservableObject {
    @Published var viewingSecondFace = false
    var card: Card

    init(card: Card) {
        self.card = card
    }

    var viewSecondFaceString: String? {
        switch card.layout {
        case .flip:
            return "Flip"
        case .modalDfc:
            return "View other side"
        case .transform:
            return "View other side"
        case .split:
            return "Rotate"
        default:
            return nil
        }
    }

    var cardRotationAngle: Angle {
        guard viewingSecondFace else { return .zero }
        switch card.layout {
        case .flip:
            return .init(degrees: 180)
        case .split:
            if (oracleText ?? "").contains("Aftermath") {
                return .init(degrees: -90)
            }

            return .init(degrees: 90)
        default:
            return .zero
        }
    }

    var cardImageURL: URL? {
        card.getImageURL(type: .normal, getSecondFace: viewingSecondFace)
    }

    var cardFlavorText: String? {
        if let faces = card.cardFaces {
            guard viewingSecondFace else { return faces[0].flavorText }
            return faces[1].flavorText
        }

        return card.flavorText
    }

    var cardManaCost: String? {
        if let faces = card.cardFaces {
            guard viewingSecondFace else { return faces[0].manaCost }
            return faces[1].manaCost
        }

        return card.manaCost
    }

    var cardName: String {
        if let faces = card.cardFaces {
            guard viewingSecondFace else { return faces[0].name }
            return faces[1].name
        }

        return card.printedName ?? card.name
    }

    var oracleText: String? {
        if let faces = card.cardFaces {
            guard viewingSecondFace else { return faces[0].oracleText }
            return faces[1].oracleText
        }

        return card.oracleText
    }

    var typeLine: String {
        if let faces = card.cardFaces {
            guard viewingSecondFace else { return faces[0].typeLine }
            return faces[0].typeLine
        }

        return card.typeLine
    }
}
