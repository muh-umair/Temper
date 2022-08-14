//
//  NetworkingTests.swift
//  
//
//  Created by Muhammad Umair on 14.08.22.
//

import XCTest
@testable import Services

final class NetworkingTests: XCTestCase {
    
    private var sut: Networking!
    
    override func setUpWithError() throws {
        sut = Networking.shared
        sut.configure(
            isStubEnabled: true,
            configuration: Constant.Network.configuration
        )
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
}

extension NetworkingTests {
    
    func test_networking_whenExecutedWithCorrectResponseType_thenResultNotNil() async throws {
        let request = FetchShiftsRequest(date: Date())
        let response: FetchShiftsResponse? = try? await sut.execute(ShiftEndpoint.fetchShifts(request))
        
        XCTAssertNotNil(response)
    }
    
    func test_networking_whenExecutedWithWrongResponseType_thenResultNil() async throws  {
        let request = FetchShiftsRequest(date: Date())
        let response: Data? = try? await sut.execute(ShiftEndpoint.fetchShifts(request))
        
        XCTAssertNil(response)
    }
}


