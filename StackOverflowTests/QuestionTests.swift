//
//  QuestionTests.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import XCTest
import Alamofire

@testable import StackOverflow

class QuestionTests: BaseCaseTest {

    /* requisite:
     *
     *    Check Connection
     *
     */

    func testCheckConnection() {

        // assert
        XCTAssertTrue((NetworkReachabilityManager()?.isReachable)!, "Check your connection and try again !!!")

    }

    /* requisite:
     *
     *    Consume API Question w/ max of 20
     *
     */

    func testConsumingAPI_Question() {

        let expectation = self.expectation(description: "request should succeed")

        // arrange
        let api = QuestionAPI()

        // act
        api.consume(object: "Swift") { (result) in

            // assert
            switch result {
            case .Success(let value):
                XCTAssertNotNil(value)
                print(value)
                break

            case .Failure(_):
                XCTFail("Failure!!!")
                break
            }

            expectation.fulfill()

        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

}
