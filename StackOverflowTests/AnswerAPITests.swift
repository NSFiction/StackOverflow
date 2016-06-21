//
//  AnswerAPITests.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/19/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import XCTest
import Alamofire

@testable import StackOverflow

class AnswerAPITests: BaseCaseTest {

    /* requisite:
     *
     *    Check Connection
     *
     */
    func testCheckConnection() {
        // assert
        XCTAssertTrue(Network.hasConnection, "Check your connection and try again !!!")
    }

    /* requisite:
     *
     *    Consume API
     *
     */
    func testConsumingAPI_Answer() {
        // arrange
        let expectation = expectationWithDescription("should receiver succeed")

        // act
        let api = AnswerAPI()
        api.consume(questionID: 37908269) { (result) in
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
        // assert
        expectation.fulfill()


        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

}
