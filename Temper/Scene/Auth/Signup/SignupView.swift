//
//  SignupView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// Signup scene
struct SignupView: View {
    // MARK: - Properties
    @StateObject var viewModel: SignupViewViewModel
    
    // MARK: View
    var body: some View {
        Text(L10n.signup_title.localized)
            .accessibility(identifier: AccessibilityIdentifier.title)
    }
}

// MARK: - Accessibility
extension SignupView {
    struct AccessibilityIdentifier {
        static let title: String = "Signup.Title"
    }
}

// MARK: Preview
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(
            viewModel: .init()
        )
    }
}
