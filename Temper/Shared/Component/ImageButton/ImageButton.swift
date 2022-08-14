//
//  ImageButton.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// A button with image and title.
///
/// Usage:
/// ```
/// ImageButton(
///     viewModel: .init(
///         title: "title",
///         imageName: "image",
///         action: {}
///     )
/// )
/// ```
struct ImageButton: View {
    // MARK: - Properties
    @StateObject var viewModel: ImageButtonViewModel
    
    // MARK: - View
    var body: some View {
        Button(action: viewModel.action) {
            HStack(spacing: Config.contentSpacing) {
                Image(viewModel.imageName)
                    .resizable()
                    .frame(width: Config.imageWidth, height: Config.imageHeight)
                
                Text(viewModel.title)
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding()
        }
    }
}

// MARK: - View Config
private extension ImageButton {
    struct Config {
        static let imageWidth: CGFloat = 22
        static let imageHeight: CGFloat = 22
        static let contentSpacing: CGFloat = 4
    }
}

// MARK: - Preview
struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(
            viewModel: .init(
                title: "Filters",
                imageName: "ic_filter",
                action: {}
            )
        ).previewLayout(.fixed(width: 300, height: 100))
    }
}
