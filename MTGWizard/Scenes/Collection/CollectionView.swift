//
//  CollectionView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/4/21.
//

import SwiftUI

struct CollectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Overview")
                .font(.title)
                .fontWeight(.bold)

            HStack {
                VStack(alignment: .leading) {
                    Text("You have 1,297 cards in your collection")
                        .padding(.bottom, 5)
                    Text("932 unique cards")
                        .padding(.bottom, 5)
                    Text("Market value of $1000")
                }
                .font(.headline)

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.93))
            )

            Text("Your lists")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            CardListList()
        }.padding()
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
