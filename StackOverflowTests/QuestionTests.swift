//
//  QuestionTests.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/18/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
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

        let expectation = expectationWithDescription("request should succeed")

        // arrange
        let api = QuestionAPI()

        // act
        api.consume(category: "Swift") { (result) in

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

        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

}
