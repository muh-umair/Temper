//
//  ImageButtonViewModel.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import Foundation

/// ViewModel for `ImageButton`
final class ImageButtonViewModel: ObservableObject {
    // MARK: - Properties
    /// Title for button.
    let title: String
    
    /// Name for button image. Image should be in assets.
    let imageName: String
    
    /// Action to perform on button tap.
    let action: () -> Void
    
    // MARK: - Initializer
    init(title: String, imageName: String, action: @escaping () -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
    }
}
