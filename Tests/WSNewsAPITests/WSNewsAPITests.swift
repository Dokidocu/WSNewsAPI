//
//  WSNewsAPITests.swift
//  
//
//  Created by Henri LA on 15.02.21.
//

import XCTest
import Alamofire
@testable import WSNewsAPI

final class WSNewsAPITests: XCTestCase {
    static let defaultTimeOut: TimeInterval = 4.0
    static let clientAPIKey: String = {
        var key: String
        if let path = Bundle.module.path(forResource: "Config", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? Dictionary<String, String>,
           let clientKey = config["ClientAPIKey"]
        {
            key = clientKey
        }
        else {
            key = ""
        }
        return key
    }()

    func testGetMissingHeaders() {
        WSNewsSwaggerClientAPI.customHeaders = [:]

        let expect = expectation(description: "Missing headers")

        WSNewsAPI.sourcesGet(language: nil,
                             country: nil,
                             category: nil)
        { (response, error) in
            guard let errorResponse = error as? ErrorResponse else { return }
            guard case ErrorResponse.error(let statusCode, _, _) = errorResponse else { return }

            XCTAssertEqual(statusCode, 401, "Should return a 401")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    static var allTests = [
        ("testGetMissingHeaders", testGetMissingHeaders)
    ]
}
