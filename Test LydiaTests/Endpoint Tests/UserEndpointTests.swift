//
//  UserEndpointTests.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 21/02/2024.
//

import XCTest
@testable import Test_Lydia

final class RequestBuilderTests: LydiaTestCase {

    func test_whenBuildingRequest_requestMustBeValid() {
        // Given
        let baseURL = "https://randomuser.me"
        let expectedPath = "https://randomuser.me/api?results=42"
        let expectedMethod = HTTPMethod.GET
        let endpoint = UsersEndpoint(limit: 42)

        // When
        let expectedrequest = RequestBuilder(baseURL: URL(string: baseURL)!).request(for: endpoint)
        
        // Then
        XCTAssertEqual(expectedrequest?.url, URL(string: expectedPath))
        XCTAssertEqual(expectedrequest?.httpMethod, expectedMethod.rawValue)
    }
}
