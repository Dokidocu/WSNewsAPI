import XCTest
import Alamofire
@testable import WSNewsAPI

final class WSNewsAPIHeadlinesTests: XCTestCase {

    override class func setUp() {
        WSNewsSwaggerClientAPI.customHeaders = ["Authorization": "Bearer \(WSNewsAPITests.clientAPIKey)"]
    }

    func testGetHeadlinesInvalidRequest() {
        let expect = expectation(description: "Invalid parameters / Bad request")

        WSNewsAPI.topHeadlinesGet(q: nil,
                                  sources: nil,
                                  country: nil,
                                  category: nil,
                                  page: nil,
                                  pageSize: nil)
        { (response, error) in
            guard let errorResponse = error as? ErrorResponse else { return }
            guard case ErrorResponse.error(let statusCode, _, let error) = errorResponse else { return }

            XCTAssertEqual(400, statusCode, "Expecting error 400")
            print(error.localizedDescription)
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetHeadlinesForUSACountry() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.topHeadlinesGet(q: nil,
                                  sources: nil,
                                  country: .us,
                                  category: nil,
                                  page: nil,
                                  pageSize: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should return a list of articles for USA")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetHeadlinesForQ() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.topHeadlinesGet(q: "economic",
                                  sources: nil,
                                  country: nil,
                                  category: nil,
                                  page: nil,
                                  pageSize: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should return a list of articles for USA")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetHeadlinesForSource() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.topHeadlinesGet(q: nil,
                                  sources: "the-washington-post",
                                  country: nil,
                                  category: nil,
                                  page: nil,
                                  pageSize: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should return a list of articles for USA")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetHeadlinesForCategorySport() {
        let expect = expectation(description: "Received valid data")

        WSNewsAPI.topHeadlinesGet(q: nil,
                                  sources: nil,
                                  country: nil,
                                  category: .sports,
                                  page: nil,
                                  pageSize: nil)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertTrue(articles.count > 0, "Should return a list of articles for USA")
            expect.fulfill()
        }

        wait(for: [expect], timeout: WSNewsAPITests.defaultTimeOut)
    }

    func testGetHeadlinesPages() {
        let expect = expectation(description: "Received valid data for page 1")
        let expectSecondPage = expectation(description: "Received valid data for page 2")

        let country = WSNewsCountry.us
        let category = WSNewsCategory.business
        let pageSize = 10
        var currentPage = 1

        WSNewsAPI.topHeadlinesGet(q: nil,
                                  sources: nil,
                                  country: country,
                                  category: category,
                                  page: currentPage,
                                  pageSize: pageSize)
        { (response, error) in
            guard nil == error else { return }
            guard let articles = response?.articles else { return }

            XCTAssertEqual(10, articles.count, "Should return a list of 10 articles")
            XCTAssertTrue(articles.count > 0, "Should return a list of articles for USA")

            currentPage += 1

            WSNewsAPI.topHeadlinesGet(q: nil,
                                      sources: nil,
                                      country: country,
                                      category: category,
                                      page: currentPage,
                                      pageSize: 10)
            { (response, error) in
                guard nil == error else { return }
                guard let articles2 = response?.articles else { return }
                var doublon = false
                articles.forEach { (article) in
                    if doublon { return }
                    doublon = articles2.contains(where: { $0 == article })
                }

                XCTAssertEqual(10, articles2.count, "Should return a list of 10 articles")
                XCTAssertFalse(doublon, "Should not have a doublon due to different page")

                expectSecondPage.fulfill()
            }

            expect.fulfill()
        }

        wait(for: [expect, expectSecondPage], timeout: WSNewsAPITests.defaultTimeOut)
    }

    static var allTests = [
        ("testGetHeadlinesInvalidRequest", testGetHeadlinesInvalidRequest),
        ("testGetHeadlinesForUSACountry", testGetHeadlinesForUSACountry),
        ("testGetHeadlinesForSource", testGetHeadlinesForSource),
        ("testGetHeadlinesForCategorySport", testGetHeadlinesForCategorySport),
        ("testGetHeadlinesPages", testGetHeadlinesPages)
    ]
}

