//
//  SettingsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/16/22.
//

import SwiftUI

struct SettingsTab: View {
    @AppStorage("HideAlchemy") var hideAlchemy = false

    var body: some View {
        Form {
            Section("Search") {
                Toggle(isOn: $hideAlchemy) {
                    Text("Hide Alchemy cards")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
