//
//  CardSortControls.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/17/22.
//

import SwiftUI
import ScryfallKit

struct CardSortControls: View {
    @Binding var sortMode: SortMode
    @Binding var sortDir: SortDirection
    
    var body: some View {
        HStack {
            Text("Sort by:")
            Picker("Sort by:", selection: $sortMode) {
                ForEach(SortMode.allCases, id: \.rawValue) { mode in
                    Text(mode.rawValue.capitalized).tag(mode)
                }
            }.pickerStyle(MenuPickerStyle())
            
            Spacer()
            
            Picker("Sort Direction", selection: $sortDir) {
                ForEach(SortDirection.allCases, id: \.rawValue) { dir in
                    Text(dir.rawValue.capitalized).tag(dir)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct CardSortControls_Previews: PreviewProvider {
    static var previews: some View {
        CardSortControls(sortMode: .constant(.set), sortDir: .constant(.asc))
    }
}
