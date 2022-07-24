//
//  Router.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/16/22.
//

import Foundation
import SwiftUI
import ScryfallKit

final class Router: ObservableObject {
    enum TabSelection {
        case search, saved, rules, settings
    }
    
    @Published var activeTab: TabSelection = .saved

    // have the card list view actually just change the tab to search
    @Published var searchPath = NavigationPath()
    @Published var savedCardsPath = NavigationPath()
    @Published var rulebookPath = NavigationPath()
}
