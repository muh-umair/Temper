//
//  LoginView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// Login Scene
struct LoginView: View {
    // MARK: - Properties
    @StateObject var viewModel: LoginViewViewModel
    
    // MARK: - View
    var body: some View {
        Text(L10n.login_title.localized)
            .accessibility(identifier: AccessibilityIdentifier.title)
    }
}

//TODO: maybe private?
// MARK: - Accessibility
extension LoginView {
    struct AccessibilityIdentifier {
        static let title: String = "Login.Title"
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: .init()
        )
    }
}
