import XCTest
import SwiftUI
import SnapshotTesting
@testable import Temper

final class InvertedButtonTests: XCTestCase {
    @MainActor func test_invertedButton_viewRendersCorrectly() {
        let viewModel = InvertedButtonViewModel(title: "Inverted button", action: {})
        
        let view = InvertedButton(viewModel: viewModel)
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 300, height: 100)
        
        assertSnapshot(matching: containerVC, as: .image(size: containerVC.view.frame.size))
    }
}
