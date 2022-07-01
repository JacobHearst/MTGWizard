//
//  SearchFilterView.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 10/16/21.
//

import SwiftUI

struct SearchFilterView: View {
    @State var viewModel: SearchFilterViewModel
    @Binding var isFiltersShown: Bool
    @Binding var filters: SearchFilters

    init(isFiltersShown: Binding<Bool>,
         filters: Binding<SearchFilters>,
         viewModel: SearchFilterViewModel) {

        self.viewModel = viewModel
        self._isFiltersShown = isFiltersShown
        self._filters = filters
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Words") {
                    Text("Text")
                    TextField("Any words in the rules box", text: $viewModel.rulesText)

                    Text("Type Line")
                    TextField("ex: Legendary Artifact Horror", text: $viewModel.typeLine)
                }

                Section("Colors") {
                    Text("Colors")
                    ColorSelectorView(selectedColors: $viewModel.colors)
                    HStack {
                        Text("Find cards that:")
                        Picker("", selection: $viewModel.colorFilterSelection) {
                            ForEach(ColorFilterOption.allCases, id: \.self) { option in
                                Text(option.label)
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }

                    Text("Commander Identity")
                    ColorSelectorView(selectedColors: $viewModel.colorIdentity)

                    Text("Mana Cost")
                    TextField("Mana symbols (eg: {W}{U}{B}{R}{G}{C})", text: $viewModel.manaCost)
                }

                Text("Rarity")
                HStack {
                    VStack {
                        Toggle(isOn: $viewModel.common) {
                            Text("Common")
                        }
                        Toggle(isOn: $viewModel.uncommon) {
                            Text("Uncommon")
                        }
                    }
                    VStack {
                        Toggle(isOn: $viewModel.rare) {
                            Text("Rare")
                        }
                        Toggle(isOn: $viewModel.mythic) {
                            Text("Mythic")
                        }
                    }
                }
            }
            .textFieldStyle(.roundedBorder)
            .navigationBarTitle(Text("Search Filters"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.isFiltersShown = false
                self.filters = viewModel.filters
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
            isFiltersShown: .constant(true),
            filters: .constant(SearchFilters()),
            viewModel: SearchFilterViewModel()
        )
    }
}
#endif
