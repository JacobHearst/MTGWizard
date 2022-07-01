//
//  RulingsList.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/21/21.
//

import SwiftUI
import ScryfallKit

struct RulingsList: View {
    var rulings: [Ruling]

    var body: some View {
        VStack(alignment: .leading) {
            if !rulings.isEmpty {
                ForEach(0..<rulings.count) { index in
                    let ruling = rulings[index]
                    Text("From \(ruling.source) (\(ruling.publishedAt)):")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(ruling.comment)

                    if index != rulings.count - 1 {
                        Divider().padding(.bottom, 2)
                    }
                }
            } else {
                Text("No rulings found")
                    .font(.subheadline)
            }
        }
    }
}

struct RulingsList_Previews: PreviewProvider {
    static var previews: some View {
        RulingsList(rulings: [])
    }
}
