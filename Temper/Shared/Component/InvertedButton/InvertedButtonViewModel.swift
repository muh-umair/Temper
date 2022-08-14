//
//  InvertedButtonViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// ViewModel for `InvertedButton`
final class InvertedButtonViewModel: ObservableObject {
    // MARK: - Properties
    /// Title for button.
    let title: String
    
    /// Action to perform on button tap.
    let action: () -> Void
    
    // MARK: - Initializer
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}
