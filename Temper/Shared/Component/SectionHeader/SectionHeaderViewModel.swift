//
//  SectionHeaderViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// ViewModel for `SectionHeader`
final class SectionHeaderViewModel: ObservableObject {
    // MARK: - Properties
    /// Text to show
    let text: String
    
    // MARK: - Initializer
    init(text: String) {
        self.text = text
    }
}
