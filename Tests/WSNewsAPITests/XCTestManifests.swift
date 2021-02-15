import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WSNewsAPISourcesTests.allTests),
        testCase(WSNewsAPIHeadlinesTests.allTests),
        testCase(WSNewsAPITests.allTests)
    ]
}
#endif
