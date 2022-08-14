import XCTest
import SwiftUI
import SnapshotTesting
@testable import Temper

class ImageButtonTests: XCTestCase {
    @MainActor func test_imageButton_viewRendersCorrectly() {
        let viewModel = ImageButtonViewModel(title: "Filters", imageName: "ic_filter", action: {})
        
        let view = ImageButton(viewModel: viewModel)
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 300, height: 100)
        
        assertSnapshot(matching: containerVC, as: .image(size: containerVC.view.frame.size))
    }
}
