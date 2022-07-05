//
//  ClearButton.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/5/22.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: clearText) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }.padding(.trailing, 8)
            }
        }
    }

    func clearText() {
        self.text = ""
    }
}
