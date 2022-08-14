//
//  ShiftRowViewTests.swift
//  TemperTests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
import SwiftUI
import SnapshotTesting
import Services
@testable import Temper

class ShiftRowViewTests: XCTestCase {
    func test_shiftRow_viewRendersCorrectly() {
        let viewModel = ShiftRowViewViewModel(
            shift: mockShift,
            locationProvider: nil
        )
        
        let view = ShiftRowView(viewModel: viewModel)
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 350, height: 320)
        
        assertSnapshot(matching: containerVC, as: .image(precision: 0.9, size: containerVC.view.frame.size), record: true)
    }
}
