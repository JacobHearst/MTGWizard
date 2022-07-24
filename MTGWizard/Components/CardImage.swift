//
//  CardImage.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/24/22.
//

import SwiftUI
import CachedAsyncImage
import ScryfallKit

struct CardImage: View {
    var card: Card
    
    var body: some View {
        if let url = card.getImageURL(types: [.normal, .png]) {
            CachedAsyncImage(url: url, content: { image in
                image.resizable()
                     .scaledToFit()
                     .cornerRadius(10)
            }) {
                VStack {
                    Text(card.name)
                    ProgressView()
                }
            }
        } else {
            Text("No image for \(card.name)")
        }
    }
}
