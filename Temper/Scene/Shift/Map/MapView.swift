//
//  MapView.swift
//  Temper
//
//  Created by Muhammad Umair on 14.08.22.
//

import SwiftUI

/// Map scene
struct MapView: View {
    // MARK: - Properties
    @StateObject var viewModel: MapViewViewModel
    
    // MARK: View
    var body: some View {
        Text(L10n.map_title.localized)
            .accessibility(identifier: AccessibilityIdentifier.title)
    }
}

// MARK: - Accessibility
extension MapView {
    struct AccessibilityIdentifier {
        static let title: String = "Map.Title"
    }
}

// MARK: Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            viewModel: .init()
        )
    }
}

