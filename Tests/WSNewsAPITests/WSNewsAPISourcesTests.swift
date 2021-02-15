import XCTest
import Alamofire
@testable import WSNewsAPI

final class WSNewsAPISourcesTests: XCTestCase {

    override class func setUp() {
        WSNewsSwaggerClientAPI.customHeaders = ["Authorization": "Bearer \(WSNewsAPITests.clientAPIKey)"]
    }

    func testGetSources() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.sourcesGet(language: nil,
                             country: nil,
                             category: nil)
        { (response, error) in
            guard nil == error else {
                return
            }

            guard let sources = response?.sources else { return }
            XCTAssert(sources.count > 0, "Should get a list of sources")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetSourcesForLanguage() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.sourcesGet(language: .fr,
                             country: nil,
                             category: nil)
        { (response, error) in
            guard nil == error else {
                return
            }

            guard let sources = response?.sources else { return }
            XCTAssert(sources.count > 0, "Should get a list of sources")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetSourcesForCountry() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.sourcesGet(language: nil,
                             country: .us,
                             category: nil)
        { (response, error) in
            guard nil == error else {
                return
            }

            guard let sources = response?.sources else { return }
            XCTAssert(sources.count > 0, "Should get a list of sources")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetSourcesForCategory() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.sourcesGet(language: nil,
                             country: nil,
                             category: .business)
        { (response, error) in
            guard nil == error else {
                return
            }

            guard let sources = response?.sources else { return }
            XCTAssert(sources.count > 0, "Should get a list of sources")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetSourcesForGermanBusinessInGermany() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.sourcesGet(language: .de,
                             country: .de,
                             category: .business)
        { (response, error) in
            guard nil == error else {
                return
            }

            guard let sources = response?.sources else { return }
            XCTAssert(sources.count > 0, "Should get a list of sources")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    static var allTests = [
        ("testGetSources", testGetSources),
        ("testGetSourcesForLanguage", testGetSourcesForLanguage),
        ("testGetSourcesForCategory", testGetSourcesForCategory),
        ("testGetSourcesForGermanBusinessInGermany", testGetSourcesForGermanBusinessInGermany)
    ]
}
