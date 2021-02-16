import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WSNewsAPITests.allTests),
        testCase(WSNewsAPISourcesTests.allTests),
        testCase(WSNewsAPIHeadlinesTests.allTests),
        testCase(WSNewsAPIArticlesTests.allTests),
        testCase(WSNewsArticlesCommandTests.allTests),
        testCase(WSNewsHeadlineCommandTests.allTests)
    ]
}
#endif
