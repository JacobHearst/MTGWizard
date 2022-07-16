//
//  GlossaryTermView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI

struct GlossaryTermView: View {
    var term: GlossaryTerm

    var body: some View {
        VStack {
            Text(term.term)
            ForEach(term.meanings, id: \.self) { meaning in
                Text(meaning)
            }
        }
    }
}

struct GlossaryTermView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryTermView(term: GlossaryTerm(term: "Test", meanings: ["Git gud"]))
    }
}
