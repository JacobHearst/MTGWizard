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
                Section("Basic") {
                    VStack(alignment: .leading) {
                        Group {
                            Text("Text")
                                .font(.headline)
                                .listRowInsets(EdgeInsets())
                            TextField("Any words in the rules box", text: $filters.oracleText)
                        }

                        Group {
                            Text("Types")
                                .font(.headline)
                            TextField("ex: Legendary Artifact Horror", text: $filters.typeLine)
                        }


                        Group {
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
                        }

                        Group {
                            Text("Commander Identity")
                                .font(.headline)
                            ColorSelector(selectedColors: $filters.colorIdentity)

                            Text("Mana Cost")
                                .font(.headline)
                            TextField("Mana symbols (eg: {W}{U}{B}{R}{G}{C})", text: $filters.manaCost)
                        }
                    }.padding([.top, .bottom])
                }

                Group {
                    Text("Rarity")
                    RaritySelector(selection: $filters.rarities)
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
