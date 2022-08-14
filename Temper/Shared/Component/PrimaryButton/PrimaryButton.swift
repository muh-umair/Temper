//
//  PrimaryButton.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// A button with title and filled background with primary color.
///
/// Usage:
/// ```
/// PrimaryButton(
///     viewModel: .init(
///         title: "title",
///         action: {}
///     )
/// )
/// ```
struct PrimaryButton: View {
    // MARK: - Properties
    @StateObject var viewModel: PrimaryButtonViewModel
    
    // MARK: - View
    var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .foregroundColor(.black)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, minHeight: Config.buttonHeight)
        .background(Color.appGreen)
        .cornerRadius(Config.cornerRadius)
    }
}

// MARK: - View Config
private extension PrimaryButton {
    struct Config {
        static let buttonHeight: CGFloat = 48
        static let cornerRadius: CGFloat = 5
    }
}

// MARK: - Preview
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            viewModel: .init(
                title: "Primary Button",
                action: {}
            )
        ).previewLayout(.fixed(width: 300, height: 60))
    }
}

