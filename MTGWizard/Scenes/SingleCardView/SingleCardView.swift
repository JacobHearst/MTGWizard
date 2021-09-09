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
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                        Text("Search")
                    }
                    Spacer()
                }
                .padding([.leading, .top])

                if let url = viewModel.cardImageURL {
                    AsyncImage(url: url)
//                        .frame(maxHeight: geometry.size.width)
                        .rotationEffect(viewModel.cardRotationAngle)
                } else {
                    Text("No image for \(viewModel.cardName)")
                }

                if let viewSecondFaceString = viewModel.viewSecondFaceString {
                    Button(action: { viewModel.viewingSecondFace.toggle() }) {
                        Text(viewSecondFaceString)
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

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView(card: MockData.shared.cards[0])
    }
}
