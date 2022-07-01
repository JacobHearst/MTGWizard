//
//  ColorSelectorViewModel.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/20/21.
//

import Foundation

final class ColorSelectorViewModel: ObservableObject {
    @Published var white: Bool = false
    @Published var blue: Bool = false
    @Published var black: Bool = false
    @Published var red: Bool = false
    @Published var green: Bool = false
    @Published var colorless: Bool = false
}
