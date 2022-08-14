//
//  SectionHeader.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// A button with image and title.
///
/// Usage:
/// ```
/// SectionHeader(
///     viewModel: .init(
///         text: "Title"
///     )
/// )
/// ```
struct SectionHeader: View {
    // MARK: - Properties
    @StateObject var viewModel: SectionHeaderViewModel
    
    // MARK: - View
    var body: some View {
        Text(viewModel.text)
            .font(.title2)
            .fontWeight(.regular)
            .foregroundColor(Color.black)
            .padding([.vertical], Config.textVerticalPadding)
    }
}

// MARK: - View Config
private extension SectionHeader {
    struct Config {
        static let textVerticalPadding: CGFloat = 4
    }
}

// MARK: Preview
struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(
            viewModel: .init(
                text: "Title"
            )
        ).previewLayout(.fixed(width: 300, height: 100))
    }
}

