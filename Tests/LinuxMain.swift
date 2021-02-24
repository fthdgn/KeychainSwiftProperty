import XCTest

import UDefaultsTests

var tests = [XCTestCaseEntry]()
tests += KeychainSwiftPropertyTests.allTests()
XCTMain(tests)
