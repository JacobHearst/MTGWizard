//
//  SearchFilterView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/16/21.
//

import SwiftUI
import ScryfallKit

struct SearchFilterView: View {
    @AppStorage("UseQuerySearch") var useQuerySearch = false
    @Binding var showFilters: Bool
    @Binding var filters: SearchFilters
    
    var body: some View {
        NavigationStack {
            Form {
                textSection
                colorSection
                metadataSection
            }
            .textFieldStyle(.roundedBorder)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: { self.showFilters = false }) {
                Text("Apply")
                    .bold()
            })
        }
    }
    
    var textSection: some View {
        Section("Card Text") {
            VStack(alignment: .leading) {
                if useQuerySearch {
                    Text("Name")
                        .font(.headline)
                    TextField("Name", text: $filters.name)
                }
                Text("Text")
                    .font(.headline)
                TextField("Any rules text (e.g. 'exile target')", text: $filters.oracleText)
                
                Text("Types")
                    .font(.headline)
                TextField("Card type (e.g. 'planeswalker')", text: $filters.typeLine)
                
                Text("Flavor")
                    .font(.headline)
                TextField("Any flavor text (e.g. 'dominaria')", text: $filters.flavorText)
            }.padding([.top, .bottom])
        }
    }
    
    var colorSection: some View {
        Section("Colors") {
            VStack(alignment: .leading) {
                Text("Card Color(s)")
                    .font(.headline)

                ColorSelector(selectedColors: $filters.colors)

                Picker("Find cards that:", selection: $filters.colorFilterOption) {
                    ForEach(ColorFilterOption.allCases, id: \.self) { option in
                        Text(option.label)
                    }
                }.pickerStyle(MenuPickerStyle())
                
                Divider()
                
                Text("Commander Identity")
                    .font(.headline)
                ColorSelector(selectedColors: $filters.colorIdentity)
                
                Text("Mana Cost")
                    .font(.headline)
                TextField("Mana cost symbols (e.g. 'wubrg')", text: $filters.manaCost)
            }.padding([.top, .bottom])
        }
    }
    
    var metadataSection: some View {
        Section("Print") {
            VStack(alignment: .leading) {
                Text("Rarity")
                    .font(.headline)
                MultiToggleView(selection: $filters.rarities, options: Card.Rarity.allCases)
                Text("Border Colors")
                    .font(.headline)
                MultiToggleView(selection: $filters.borderColors, options: BorderColor.allCases)
            }.padding([.top, .bottom])
        }
    }
}

#if DEBUG
struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView(
            showFilters: .constant(true),
            filters: .constant(SearchFilters())
        )
    }
}
#endif
