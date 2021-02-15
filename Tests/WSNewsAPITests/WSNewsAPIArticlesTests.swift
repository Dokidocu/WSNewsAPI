import XCTest
import Alamofire
@testable import WSNewsAPI
// q, qInTitle, sources, domains
final class WSNewsAPIArticlesTests: XCTestCase {

    override class func setUp() {
        WSNewsSwaggerClientAPI.customHeaders = ["Authorization": "Bearer \(WSNewsAPITests.clientAPIKey)"]
    }


    func testGetArticlesInvalidRequest() {
        let expect = expectation(description: "Invalid parameters / Bad request")

        WSNewsAPI.everythingGet(page: 1, pageSize: 20)
        { (response, error) in
            guard let errorResponse = error as? ErrorResponse else { return }
            guard case ErrorResponse.error(let statusCode, _, _) = errorResponse else { return }

            XCTAssertEqual(400, statusCode, "Expecting error 400")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetArticlesForQ() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.everythingGet(page: 1,
                                pageSize: 20,
                                q: "finance",
                                qInTitle: nil,
                                sources: nil,
                                domains: nil,
                                excludeDomains: nil,
                                from: nil,
                                to: nil,
                                language: nil,
                                sortBy: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should not return an empty list")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetArticlesForQInTitle() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.everythingGet(page: 1,
                                pageSize: 20,
                                q: nil,
                                qInTitle: "finance",
                                sources: nil,
                                domains: nil,
                                excludeDomains: nil,
                                from: nil,
                                to: nil,
                                language: nil,
                                sortBy: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should not return an empty list")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetArticlesForSources() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.everythingGet(page: 1,
                                pageSize: 20,
                                q: nil,
                                qInTitle: nil,
                                sources: "the-washington-post",
                                domains: nil,
                                excludeDomains: nil,
                                from: nil,
                                to: nil,
                                language: .en,
                                sortBy: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should not return an empty list")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetArticlesDomains() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.everythingGet(page: 1,
                                pageSize: 20,
                                q: nil,
                                qInTitle: nil,
                                sources: nil,
                                domains: "bbc.co.uk, techcrunch.com",
                                excludeDomains: nil,
                                from: nil,
                                to: nil,
                                language: nil,
                                sortBy: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should not return an empty list")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetArticlesExcludedDomains() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.everythingGet(page: 1,
                                pageSize: 20,
                                q: nil,
                                qInTitle: nil,
                                sources: nil,
                                domains: "thenextweb.com",
                                excludeDomains: "bbc.co.uk,techcrunch.com",
                                from: nil,
                                to: nil,
                                language: nil,
                                sortBy: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should not return an empty list")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    static var allTests = [
        ("testGetArticlesInvalidRequest", testGetArticlesInvalidRequest),
        ("testGetArticlesForQ", testGetArticlesForQ),
        ("testGetArticlesForQInTitle", testGetArticlesForQInTitle),
        ("testGetArticlesDomains", testGetArticlesDomains),
        ("testGetArticlesExcludedDomains", testGetArticlesExcludedDomains),
        ("testGetArticlesForSources", testGetArticlesForSources)
    ]
}


