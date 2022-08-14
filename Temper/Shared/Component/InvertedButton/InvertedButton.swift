//
//  InvertedButton.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// A button with title and black border.
///
/// Usage:
/// ```
/// InvertedButton(
///     viewModel: .init(
///         title: "title",
///         action: {}
///     )
/// )
/// ```
struct InvertedButton: View {
    // MARK: - Properties
    @StateObject var viewModel: InvertedButtonViewModel
    
    // MARK: - View
    var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .foregroundColor(.black)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, minHeight: Config.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: Config.cornerRadius)
                .stroke(.black, lineWidth: Config.borderStroke)
        )
    }
}

// MARK: - View Config
private extension InvertedButton {
    struct Config {
        static let buttonHeight: CGFloat = 48
        static let cornerRadius: CGFloat = 5
        static let borderStroke: CGFloat = 1
    }
}

// MARK: - Preview
struct InvertedButton_Previews: PreviewProvider {
    static var previews: some View {
        InvertedButton(
            viewModel: .init(
                title: "Inverted Button",
                action: {}
            )
        ).previewLayout(.fixed(width: 300, height: 60))
    }
}
