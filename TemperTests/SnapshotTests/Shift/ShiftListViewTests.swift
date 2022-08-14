//
//  ShiftListViewTests.swift
//  TemperTests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
import SwiftUI
import SnapshotTesting
import Services
@testable import Temper

final class ShiftListViewTests: XCTestCase {
    func test_shiftList_viewRendersCorrectly() {
        let mockRepository = MockShiftRepository()
        mockRepository.shifts = [mockShift]
        
        let view = ShiftListView(
            viewModel: ShiftListViewViewModel(
                shiftsRepository: mockRepository
            )
        )
        
        let containerVC = UIHostingController(rootView: view)
        containerVC.view.frame = .init(x: 0, y: 0, width: 350, height: 750)
        
        assertSnapshot(matching: containerVC, as: .image(precision: 0.9, size: containerVC.view.frame.size))
    }
}
