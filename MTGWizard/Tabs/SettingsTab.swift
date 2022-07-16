//
//  SettingsView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/16/22.
//

import SwiftUI

struct SettingsTab: View {
    @AppStorage("HideAlchemy") var hideAlchemy = false
    @AppStorage("UseQuerySearch") var useQuerySearch = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Search") {
                    Toggle(isOn: $hideAlchemy) {
                        Text("Hide Alchemy cards")
                    }
                    Toggle(isOn: $useQuerySearch) {
                        Text("Search using Scryfall syntax instead of name")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
