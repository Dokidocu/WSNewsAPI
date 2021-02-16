import XCTest
@testable import WSNewsAPI

final class WSNewsArticlesCommandTests: XCTestCase {

    func testNextPageStart() {
        let command = WSNewsArticlesCommand()
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
        let command = WSNewsArticlesCommand()
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
        let command = WSNewsArticlesCommand(pageSize: expectedPageSize)
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
        var command = WSNewsArticlesCommand()
        let expDomains = "Toto"
        let expExcludedomains = "Momo"
        let expFrom = Date()
        let expLanguage = WSNewsLanguage.de
        let expQInTitle = "Qtitle"
        let expQuery = "Hello World"
        let expSortBy = WSNewsSortBy.relevancy
        let expSources = "Sources"
        let expTo: Date? = nil
        command.domains = expDomains
        command.excludeDomains = expExcludedomains
        command.from = expFrom
        command.language = expLanguage
        command.qInTitle = expQInTitle
        command.query = expQuery
        command.sortBy = expSortBy
        command.sources = expSources
        command.to = expTo
        _ = command.nextPage()
        _ = command.nextPage()
        let savedCommand = command.savedCommand()
        command = WSNewsArticlesCommand(savedCommand: savedCommand)

        XCTAssertEqual(command.domains, savedCommand.domains, "domains should be equal")
        XCTAssertEqual(command.excludeDomains, savedCommand.excludeDomains, "excludeDomains should be equal")
        XCTAssertEqual(command.from, savedCommand.from, "from should be equal")
        XCTAssertEqual(command.language, savedCommand.language, "language should be equal")
        XCTAssertEqual(command.qInTitle, savedCommand.qInTitle, "qInTitle should be equal")
        XCTAssertEqual(command.query, savedCommand.query, "query should be equal")
        XCTAssertEqual(command.sortBy, savedCommand.sortBy, "sortBy should be equal")
        XCTAssertEqual(command.sources, savedCommand.sources, "sources should be equal")
        XCTAssertEqual(command.to, savedCommand.to, "to should be equal")
        XCTAssertEqual(command.page, savedCommand.page, "Page should be equal")
        XCTAssertEqual(command.pageSize, savedCommand.pageSize, "Page should be equal")
    }

    func testSavedCommandRestore() {
        var command = WSNewsArticlesCommand()
        let expDomains = "Toto"
        let expExcludedomains = "Momo"
        let expFrom = Date()
        let expLanguage = WSNewsLanguage.de
        let expQInTitle = "Qtitle"
        let expQuery = "Hello World"
        let expSortBy = WSNewsSortBy.relevancy
        let expSources = "Sources"
        let expTo: Date? = nil
        command.domains = expDomains
        command.excludeDomains = expExcludedomains
        command.from = expFrom
        command.language = expLanguage
        command.qInTitle = expQInTitle
        command.query = expQuery
        command.sortBy = expSortBy
        command.sources = expSources
        command.to = expTo
        _ = command.nextPage()
        _ = command.nextPage()
        let savedCommand = command.savedCommand()
        command = WSNewsArticlesCommand(savedCommand: savedCommand)
        let nextRequest = command.nextPage()

        guard let urlComponents = URLComponents(string: nextRequest.URLString) else {
            XCTFail("urlComponents should not be nil")
            return
        }

        guard let language = urlComponents.queryItems?.first(where: { $0.name == "language" }) else {
            XCTFail("'language' key should be present")
            return
        }

        guard let query = urlComponents.queryItems?.first(where: { $0.name == "q" }) else {
            XCTFail("'query' key should be present")
            return
        }

        guard let sortBy = urlComponents.queryItems?.first(where: { $0.name == "sortBy" }) else {
            XCTFail("'sortBy' key should be present")
            return
        }

        guard let page = urlComponents.queryItems?.first(where: { $0.name == "page" }) else {
            XCTFail("'page' key should be present")
            return
        }

        XCTAssertEqual(language.value, savedCommand.language?.rawValue, "language value should be equal")
        XCTAssertEqual(query.value, savedCommand.query, "query value should be equal")
        XCTAssertEqual(sortBy.value, savedCommand.sortBy?.rawValue, "sortBy value should be equal")
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
