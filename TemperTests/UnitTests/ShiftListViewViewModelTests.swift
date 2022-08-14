//
//  ShiftListViewViewModelTests.swift
//  TemperTests
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
import Services
import CoreLocation
@testable import Temper

class ShiftListViewViewModelTests: XCTestCase {
    
    private var sut: ShiftListViewViewModel!
    private var mockRepository: MockShiftRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockRepository = MockShiftRepository()
        
        sut = ShiftListViewViewModel(
            shiftsRepository: mockRepository
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}

// MARK: - fetchShifts()
extension ShiftListViewViewModelTests {
    func test_fetchShifts_whenRepositoryReturnsShifts_thenHasProperData() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = [mockShift]
        mockRepository.error = nil
        
        XCTAssertTrue(sut.shifts.isEmpty)
        XCTAssertFalse(sut.isLoadingShifts)
        
        Task {
            await sut.fetchShifts()
            
            XCTAssertEqual(sut.shifts.count, 1)
            XCTAssertEqual(sut.shifts.first!.shifts.count, 1)
            XCTAssertNotNil(sut.errorMessage)
            XCTAssertFalse(sut.isLoadingShifts)
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_fetchShifts_whenRepositoryReturnsError_thenHasProperData() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = nil
        mockRepository.error = NetworkError.undefined
        
        XCTAssertTrue(sut.shifts.isEmpty)
        XCTAssertFalse(sut.isLoadingShifts)
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertTrue(sut.shifts.isEmpty)
            XCTAssertNotNil(sut.errorMessage)
            XCTAssertFalse(sut.isLoadingShifts)
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
}

// MARK: - append(shifts:)
extension ShiftListViewViewModelTests {
    func test_appendShifts_whenNoNewShifts_thenDoesntChangeData() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = [mockShift]
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 1)
            let previousSectionsCount = sut.shifts.count
            let previousShiftsCountForFirstSection = sut.shifts.first!.shifts.count
            
            sut.append(shifts: [])
            XCTAssertEqual(sut.shifts.count, previousSectionsCount)
            XCTAssertEqual(sut.shifts.first!.shifts.count, previousShiftsCountForFirstSection)
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_appendShifts_whenNewShiftsAreForSameDay_thenAppendToOldSection() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = [mockShift]
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 1)
            let previousSectionsCount = sut.shifts.count
            let previousShiftsCountForFirstSection = sut.shifts.first!.shifts.count
            
            let newShifts = [
                getMockShift(id: "2", startsAt: mockShift.startsAt)
            ]
            sut.append(shifts: newShifts)
            
            XCTAssertEqual(sut.shifts.count, previousSectionsCount)
            XCTAssertEqual(sut.shifts.first!.shifts.count, previousShiftsCountForFirstSection + newShifts.count)
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_appendShifts_whenNewShiftsAreForNextDay_thenAppendToNewSection() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = [mockShift]
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 1)
            let previousSectionsCount = sut.shifts.count
            let previousShiftsCountForFirstSection = sut.shifts.first!.shifts.count
            
            let newShifts = [
                getMockShift(
                    id: "2",
                    startsAt: mockShift.startsAt.add(.day, 1)!
                )
            ]
            sut.append(shifts: newShifts)
            
            XCTAssertEqual(sut.shifts.count, previousSectionsCount + 1)
            XCTAssertEqual(sut.shifts.first!.shifts.count, previousShiftsCountForFirstSection)
            XCTAssertEqual(sut.shifts.last!.shifts.count, newShifts.count)
        }
        
        wait(for: [exp], timeout: 2.0)
    }
}

// MARK: - sectionHeader(from:)
extension ShiftListViewViewModelTests {
    func test_sectionHeader_whenDateNil_thenReturnsNil() {
        let result = sut.sectionHeader(from: nil)
        XCTAssertNil(result)
    }
    
    func test_sectionHeader_whenDateNotNil_thenReturnsProperData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d MMMM"
        let date = Date()
        let expected = formatter.string(from: date)
        
        let result = sut.sectionHeader(from: date)
        XCTAssertEqual(result, expected)
    }
}

// MARK: - shouldFetchNextShifts(shiftId:, startsAt:)
extension ShiftListViewViewModelTests {
    func test_shouldFetchNextShifts_whenShiftNotAtThreshold_thenReturnsFalse() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = (0...10).map { idx in
            getMockShift(id: String(describing: idx), startsAt: Date())
        }
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 10)
            
            let result = sut.shouldFetchNextShifts(shiftId: "1", startsAt: Date())
            XCTAssertFalse(result)
            
        }
        
        wait(for: [exp], timeout: 2.0)
    }
    
    func test_shouldFetchNextShifts_whenShiftAtThreshold_thenReturnsTrue() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = (0...10).map { idx in
            getMockShift(id: String(describing: idx), startsAt: Date())
        }
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 10)
            
            let result = sut.shouldFetchNextShifts(shiftId: "5", startsAt: Date())
            XCTAssertTrue(result)
            
        }
        
        wait(for: [exp], timeout: 2.0)
    }
}

// MARK: - resetShifts()
extension ShiftListViewViewModelTests {
    func test_resetShifts_whenCalled_thenRemoveAllData() {
        let exp = expectation(description: "Waiting for fetchShifts() to complete")
        mockRepository.shifts = [mockShift]
        mockRepository.error = nil
        
        Task {
            await sut.fetchShifts()
            exp.fulfill()
            
            XCTAssertEqual(sut.shifts.count, 1)
            
            sut.resetShifts()
            XCTAssertTrue(sut.shifts.isEmpty)
            
        }
        
        wait(for: [exp], timeout: 2.0)
    }
}

// MARK: - Helper
private extension ShiftListViewViewModelTests {
    func getMockShift(id: String, startsAt: Date) -> Shift {
        Shift(
            id: id,
            startsAt: startsAt,
            endsAt: startsAt.add(.hour, 4) ?? startsAt,
            earningsPerHourCurrencyValue: "EUR",
            earningsPerHourAmountValue: 14.0,
            job: .init(
                id: "q6pw9z",
                title: "Enthousiaste Rider",
                imageURL: URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero380/41774.jpg")!,
                clientName: "Flink - Delft Centrum",
                address: .init(
                    coordinate: CLLocationCoordinate2D(latitude: 52.00836, longitude: 4.361479),
                    fullAddress: "Breestraat 37 2611RE Delft",
                    directionsURL: URL(string: "https://www.google.com/maps/dir/?api=1&destination=Breestraat+37%2CDelft+2611RE%2CThe+Netherlands")
                ),
                category: "Delivery"
            )
        )
    }
}
