//
//  View+TextFieldAlert.swift
//  MTGWizard
//
//  Created by Jacob Hearst on 7/11/22.
//

import SwiftUI

extension View {
    func presentTextFieldAlert(title: String,
                               message: String,
                               hintText: String,
                               primaryActionTitle: String,
                               secondaryActionTitle: String,
                               primaryAction: @escaping (String) -> Void,
                               secondaryAction: @escaping () -> Void) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryActionTitle, style: .cancel) { _ in
            secondaryAction()
        })
        
        alert.addAction(.init(title: primaryActionTitle, style: .default) { _ in
            primaryAction(alert.textFields?[0].text ?? "")
        })
        
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController() -> UIViewController {
        guard
            let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let root = screen.windows.first?.rootViewController
        else {
            return .init()
        }
        
        return root
    }
}
