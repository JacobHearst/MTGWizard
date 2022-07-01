//
//  ColorSelector.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/20/21.
//

import SwiftUI
import ScryfallKit

struct ColorSelection {
    var white = false
    var blue = false
    var black = false
    var red = false
    var green = false
    var colorless = false

    var selection: [ScryfallKit.Color] {
        return [
            white ? .W : nil,
            blue ? .U : nil,
            black ? .B : nil,
            red ? .R : nil,
            green ? .G : nil,
            colorless ? .C : nil
        ].compactMap({ $0 })
    }
}

struct ColorSelectorView: View {
    @Binding var selectedColors: ColorSelection

    var body: some View {
        HStack {
            VStack {
                Toggle(isOn: $selectedColors.white) {
                    Image("{W}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("White")
                }
                Toggle(isOn: $selectedColors.black) {
                    Image("{B}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Black")
                }
                Toggle(isOn: $selectedColors.green) {
                    Image("{G}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Green")
                }
            }
            VStack {
                Toggle(isOn: $selectedColors.blue) {
                    Image("{U}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Blue")
                }
                Toggle(isOn: $selectedColors.red) {
                    Image("{R}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Red")
                }
                Toggle(isOn: $selectedColors.colorless) {
                    Image("{C}")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Colorless")
                }
            }
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(selectedColors: .constant(.init()))
    }
}
