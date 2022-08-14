import XCTest
import SwiftUI
import SnapshotTesting
@testable import Temper

class PrimaryButtonTests: XCTestCase {
    @MainActor func test_primaryButton_viewRendersCorrectly() {
        let viewModel = PrimaryButtonViewModel(title: "Primary button", action: {})
        
        let view = PrimaryButton(viewModel: viewModel)
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 300, height: 100)
        
        assertSnapshot(matching: containerVC, as: .image(size: containerVC.view.frame.size))
    }
}
