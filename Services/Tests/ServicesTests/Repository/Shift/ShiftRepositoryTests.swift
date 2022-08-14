//
//  ShiftRepositoryTests.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
@testable import Services

final class ShiftRepositoryTests: XCTestCase {
    
    private var sut: ShiftRepository!
    
    override func setUpWithError() throws {
        let networking = Networking.shared
        networking.configure(
            isStubEnabled: true,
            configuration: Constant.Network.configuration
        )
        sut = ShiftRepository(networking: networking)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}

extension ShiftRepositoryTests {
    
    func test_repository_whenFetchShiftsExecuted_thenResponseNotNil() async throws {
        let request = FetchShiftsRequest(date: Date())
        let response: FetchShiftsResponse? = try? await sut.fetchShifts(request)
        
        XCTAssertNotNil(response)
    }
}

