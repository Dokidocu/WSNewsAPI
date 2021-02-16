import XCTest
@testable import WSNewsAPI

final class WSNewsHeadlineCommandTests: XCTestCase {

    func testNextPageStart() {
        let command = WSNewsHeadlineCommand()
        let nextRequest = command.nextPage()
        guard let urlComponents = URLComponents(string: nextRequest.URLString) else {
            XCTFail("urlComponents should not be nil")
            return
        }

        guard let page = urlComponents.queryItems?.first(where: { $0.name == "page" }) else {
            XCTFail("'page' key should be present")
            return
        }

        XCTAssertEqual(page.value, "1", "Page value should be equal to 1")
    }

    func testDefaultPageSize() {
        let command = WSNewsHeadlineCommand()
        let nextRequest = command.nextPage()
        guard let urlComponents = URLComponents(string: nextRequest.URLString) else {
            XCTFail("urlComponents should not be nil")
            return
        }

        guard let pageSize = urlComponents.queryItems?.first(where: { $0.name == "pageSize" }) else {
            XCTFail("'pageSize' key should be present")
            return
        }

        XCTAssertEqual(pageSize.value, "20", "Page value should be equal to 20")
    }

    func testCustomPageSize() {
        let expectedPageSize = 100
        let command = WSNewsHeadlineCommand(pageSize: expectedPageSize)
        let nextRequest = command.nextPage()
        guard let urlComponents = URLComponents(string: nextRequest.URLString) else {
            XCTFail("urlComponents should not be nil")
            return
        }

        guard let pageSize = urlComponents.queryItems?.first(where: { $0.name == "pageSize" }) else {
            XCTFail("'pageSize' key should be present")
            return
        }

        XCTAssertEqual(pageSize.value, "\(expectedPageSize)", "Page value should be equal to 100")
    }

    func testSavedCommand() {
        var command = WSNewsHeadlineCommand()
        command.country = .us
        command.query = "Hello"
        command.category = .business
        _ = command.nextPage()
        _ = command.nextPage()
        let savedCommand = command.savedCommand()
        command = WSNewsHeadlineCommand(savedCommand: savedCommand)

        XCTAssertEqual(command.country, savedCommand.country, "Country should be equal")
        XCTAssertEqual(command.query, savedCommand.query, "Query should be equal")
        XCTAssertEqual(command.category, savedCommand.category, "Category should be equal")
        XCTAssertEqual(command.page, savedCommand.page, "Page should be equal")
        XCTAssertEqual(command.pageSize, savedCommand.pageSize, "Page should be equal")
    }

    func testSavedCommandRestore() {
        var command = WSNewsHeadlineCommand()
        command.country = .us
        command.query = "Hello"
        command.category = .business
        _ = command.nextPage()
        _ = command.nextPage()
        let savedCommand = command.savedCommand()
        command = WSNewsHeadlineCommand(savedCommand: savedCommand)
        let nextRequest = command.nextPage()

        guard let urlComponents = URLComponents(string: nextRequest.URLString) else {
            XCTFail("urlComponents should not be nil")
            return
        }

        guard let country = urlComponents.queryItems?.first(where: { $0.name == "country" }) else {
            XCTFail("'country' key should be present")
            return
        }

        guard let query = urlComponents.queryItems?.first(where: { $0.name == "q" }) else {
            XCTFail("'query' key should be present")
            return
        }

        guard let category = urlComponents.queryItems?.first(where: { $0.name == "category" }) else {
            XCTFail("'category' key should be present")
            return
        }

        guard let page = urlComponents.queryItems?.first(where: { $0.name == "page" }) else {
            XCTFail("'page' key should be present")
            return
        }

        XCTAssertEqual(country.value, savedCommand.country?.rawValue, "Country value should be equal")
        XCTAssertEqual(query.value, savedCommand.query, "query value should be equal")
        XCTAssertEqual(category.value, savedCommand.category?.rawValue, "category value should be equal")
        XCTAssertEqual(page.value, "3", "Page value should be equal to 1")
    }

    static var allTests = [
        ("testNextPageStart", testNextPageStart),
        ("testDefaultPageSize", testDefaultPageSize),
        ("testCustomPageSize", testCustomPageSize),
        ("testSavedCommand", testSavedCommand),
        ("testSavedCommandRestore", testSavedCommandRestore)
    ]

}
