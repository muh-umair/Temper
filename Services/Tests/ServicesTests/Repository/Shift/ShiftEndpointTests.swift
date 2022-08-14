//
//  ShiftEndpointTests.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
@testable import Services

final class ShiftEndpointTests: XCTestCase {
    
    private var sut: ShiftEndpoint!
    
    override func tearDownWithError() throws {
        sut = nil
    }
}

extension ShiftEndpointTests {
    
    func test_shiftEndpoint_whenConstructedWithFetchShiftsRequest_thenURLRequestNotNil()  {
        let request = FetchShiftsRequest(date: Date())
        sut = .fetchShifts(request)
        
        XCTAssertNotNil(sut.urlRequest)
    }
    
}
