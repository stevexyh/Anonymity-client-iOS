//
//  File Name     : ChatDataService_Tests.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/15 20:10.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import XCTest

// Unit Test
// Naming Structure: func test_[Unit of Work]_[State Under Test]_[Expected Behavior][_stress]()
// Naming Structure: func test_[struct / class]_[var / func]_[Expected Result][_stress]()
// Testing Structure: Given, When, Then
@testable import Anonymity

class ChatDataService_Tests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_ChatDataService_symKeyGen_ShouldReturnSalt() async {
        // Given
        let ds = ChatDataService.self
        let userID = "26qn8z3JRhh4LWPIjaB7XBY3jy52"
        let chatID = "26qn8z3JRhh4LWPIjaB7XBY3jy52Hwx4lGQp2NXnhYvuFZbCvjXnn5K2"
        let size = 256

        // When
        let salt = await ds.symKeyGen(with: userID, for: chatID, size: size)

        // Then
        print(salt?.base64EncodedString() ?? "nil salt")
        XCTAssertNotNil(salt, "SymKey with User[\(userID)] for Chat[\(chatID)] generation failed.")
    }
}
