//
//  SearchFilterView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/16/21.
//

import SwiftUI

struct SearchFilterView: View {
    @Binding var showFilters: Bool
    @Binding var filters: SearchFilters

    var body: some View {
        NavigationView {
            Form {
                Section("Card Text") {
                    VStack(alignment: .leading) {
                            Text("Text")
                                .font(.headline)
                                .listRowInsets(EdgeInsets())
                            TextField("Any words in the rules box", text: $filters.oracleText)

                            Text("Types")
                                .font(.headline)
                            TextField("ex: Legendary Artifact Horror", text: $filters.typeLine)
                    }.padding([.top, .bottom])
                }

                Section("Colors") {
                    VStack(alignment: .leading) {
                            Text("Colors")
                                .font(.headline)
                            ColorSelector(selectedColors: $filters.colors)
                            HStack {
                                Text("Find cards that:")
                                Picker("", selection: $filters.colorFilterOption) {
                                    ForEach(ColorFilterOption.allCases, id: \.self) { option in
                                        Text(option.label)
                                    }
                                }.pickerStyle(MenuPickerStyle())
                            }

                            Text("Commander Identity")
                                .font(.headline)
                            ColorSelector(selectedColors: $filters.colorIdentity)

                            Text("Mana Cost")
                                .font(.headline)
                            TextField("{W}{U}{B}{R}{G}{C}", text: $filters.manaCost)
                    }.padding([.top, .bottom])
                }

                Section("Metadata") {
                    VStack(alignment: .leading) {
                        Text("Rarity")
                            .font(.headline)
                        RaritySelector(selection: $filters.rarities)
                    }.padding([.top, .bottom])
                }
            }
            .textFieldStyle(.roundedBorder)
            .navigationBarTitle(Text("Search Filters"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showFilters = false
            }) {
                Text("Apply").bold()
            })
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
