//
//  FilterView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// Filter scene
struct FilterView: View {
    // MARK: - Properties
    @StateObject var viewModel: FilterViewViewModel
    
    // MARK: View
    var body: some View {
        Text(L10n.filters_title.localized)
            .accessibility(identifier: AccessibilityIdentifier.title)
    }
}

// MARK: - Accessibility
private extension FilterView {
    struct AccessibilityIdentifier {
        static let title: String = "Filter.Title"
    }
}

// MARK: Preview
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(
            viewModel: .init()
        )
    }
}
