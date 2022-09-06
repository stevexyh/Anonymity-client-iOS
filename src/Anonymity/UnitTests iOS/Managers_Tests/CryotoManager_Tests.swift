//
//  File Name     : CryotoManager_Tests.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.5
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/8/24 00:14.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import CryptoKit
import XCTest

// Unit Test
// Naming Structure: func test_[Unit of Work]_[State Under Test]_[Expected Behavior][_stress]()
// Naming Structure: func test_[struct / class]_[var / func]_[Expected Result][_stress]()
// Testing Structure: Given, When, Then
@testable import Anonymity

class CryotoManager_Tests: XCTestCase {
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

    func testPerformance_CryptoManager_ECCKeyGen_ShouldReturnKey_stress() {
        // Given
        var results: [Int] = []
        let loopCount = 10000

        // When
        measure {
            var tmpCnt = 0
            for _ in 0 ..< loopCount {
                _ = Curve25519.KeyAgreement.PrivateKey().publicKey
                tmpCnt += 1
            }

            results.append(tmpCnt)
        }

        // Then
        XCTAssertTrue(results.allSatisfy { $0 == loopCount })
    }

    func testPerformance_CryptoManager_symKeyDerivation_ShouldReturnTrue_stress() {
        // Given
        let manager = CryptoManager.self

        var results: [Bool] = []
        let pubKeyB64Str: String = "evbVt3dKGFPRHZdtY+tiz82UiyWGxc0HGr40Zfrr5mM="
        let chatID: Chat.ID = "VQK7fMLhXcYv90LC6008GRmo48X2Wb3vtmtChGMJ94AULgvPh1ZxLY22"
        guard let salt: Data = Data(base64Encoded: "J8iD6a1wqMylSSO+") else {
            XCTFail()
            return
        }

        // When
        measure {
            for _ in 0 ..< 10000 {
                let status = manager.symKeyDerivation(with: pubKeyB64Str, for: chatID, salt: salt)
                results.append(status)
            }
        }

        // Then
        XCTAssertTrue(results.allSatisfy { $0 == true })
    }

    func testPerformance_CryptoManager_symEncryptForData_ShouleReturnEncryptedData_stress() {
        // Given

        func genRandomData(size: Int) -> Data? {
            var bytes = [Int8](repeating: 0, count: size)
            guard SecRandomCopyBytes(kSecRandomDefault, size, &bytes) == errSecSuccess else {
                XCTFail()
                return nil
            }

            let data: Data = Data(bytes: &bytes, count: size)

            return data
        }

        let manager = CryptoManager.self
        let chatID: Chat.ID = "VQK7fMLhXcYv90LC6008GRmo48X2Wb3vtmtChGMJ94AULgvPh1ZxLY22"

        let dataSize100M = 100000000
        guard let data = genRandomData(size: dataSize100M) else { return }

        var results: [Bool] = []
        let secKey = SymmetricKey(size: .bits256)

        // When
        measure {
            for _ in 0 ..< 100 {
                let status = manager.symEncrypt(for: data, in: chatID, with: secKey) != nil
                results.append(status)
            }
        }

        // Then
        XCTAssertTrue(results.allSatisfy { $0 == true })
    }
}
