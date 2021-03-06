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
        NavigationStack {
            Form {
                Section("Search") {
                    Toggle(isOn: $hideAlchemy) {
                        Text("Hide Alchemy cards")
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
