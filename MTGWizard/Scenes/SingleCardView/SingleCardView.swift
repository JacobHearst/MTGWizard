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
    @StateObject private var viewModel: SingleCardViewModel

    init(card: Card) {
        _viewModel = StateObject(wrappedValue: SingleCardViewModel(card: card))
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    Spacer()
                }
                .padding([.leading, .top])

                if let url = viewModel.cardImageURL {
                    AsyncImage(url: url, content: { image in
                        viewModel.buildAsyncImage(image: image, geometry: geo)
                    }) { ProgressView() }
                } else {
                    Text("No image for \(viewModel.cardName)")
                }

                HStack {
                    Button(action: { viewModel.toggleSaved(presentationMode: self.presentationMode) }) {
                        if viewModel.isSaved {
                            Label("Unsave card", systemImage: "minus.square.fill")
                        } else {
                            Label("Save Card", systemImage: "plus.square.fill")
                        }
                    }
                    if let viewSecondFaceString = viewModel.viewSecondFaceString {
                        Button(action: { viewModel.viewingSecondFace.toggle() }) {
                            Text(viewSecondFaceString)
                        }
                    }
                }

                CardDescription()
                    .padding()
                    .environmentObject(viewModel)

                Spacer()
            }
        }.navigationBarHidden(true)
    }
}
