//
//  CardListList.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 9/4/21.
//

import SwiftUI

struct CardListList: View {
    var body: some View {
        List {
            Text("Mythics")
            Text("Upgrades")
        }
    }
}

struct CardListList_Previews: PreviewProvider {
    static var previews: some View {
        CardListList()
    }
}
