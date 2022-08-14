import XCTest
import SwiftUI
import SnapshotTesting
@testable import Temper

final class SectionHeaderTests: XCTestCase {
    @MainActor func test_sectionHeader_viewRendersCorrectly() {
        let viewModel = SectionHeaderViewModel(text: "Title")
        
        let view = SectionHeader(viewModel: viewModel)
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 300, height: 100)
        
        assertSnapshot(matching: containerVC, as: .image(size: containerVC.view.frame.size))
    }
}
