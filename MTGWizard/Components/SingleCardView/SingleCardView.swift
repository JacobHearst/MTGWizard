//
//  SingleCardView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/7/21.
//

import SwiftUI
import ScryfallKit

struct SingleCardView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("SavedCards") var savedCards = [Card]()

    @State private var viewingSecondFace = false
    @State private var isSaved = false

    var card: Card
    
    init(card: Card) {
        self.card = card
        _isSaved = State(initialValue: savedCards.contains { $0 == card })
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                buildAsyncImage(geometry: geo)

                HStack {
                    saveButton
                    if let viewSecondFaceString = viewSecondFaceString {
                        Button(action: { viewingSecondFace.toggle() }) {
                            Text(viewSecondFaceString)
                        }
                    }
                }

                CardDescription(card: card, viewingSecondFace: viewingSecondFace)
                    .padding()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Subviews
    var saveButton: some View {
        Button(action: { toggleSaved() }) {
            if isSaved {
                Label("Unsave card", systemImage: "minus.square.fill")
            } else {
                Label("Save Card", systemImage: "plus.square.fill")
            }
        }
    }
    
    func buildAsyncImage(geometry: GeometryProxy) -> some View {
        if let url = card.getImageURL(types: [.png, .normal], getSecondFace: viewingSecondFace) {
            return AnyView(AsyncImage(url: url, content: { image in
                self.resizeCardImage(geometry: geometry, image: image)
            }) { ProgressView() })
        } else {
            return AnyView(Text("No image for \(card.name)"))
        }
    }
    
    func resizeCardImage(geometry: GeometryProxy, image: Image) -> some View {
        let newImage = image
            .resizable()
            .scaledToFit()
            .rotationEffect(cardRotationAngle)
        
        if viewingSecondFace && ![.transform, .flip, .modalDfc].contains(self.card.layout) {
            return newImage.frame(maxHeight: geometry.size.width * 0.9)
        } else {
            return newImage.frame(maxWidth: geometry.size.width * 0.9)
        }
    }
    
    
    // MARK: Computed vars
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
        let oracleText = try? card.getAttributeForFace(keyPath: \.oracleText, useSecondFace: viewingSecondFace)

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
}

// MARK: Button handlers
extension SingleCardView {
    func toggleSaved() {
        if isSaved {
            savedCards.removeAll { $0 == card }
        } else {
            savedCards.append(card)
        }

        isSaved.toggle()
    }
}
