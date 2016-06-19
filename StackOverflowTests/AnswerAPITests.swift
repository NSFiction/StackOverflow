//
//  AnswerAPITests.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/19/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
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

        // assert
        expectation.fulfill()


        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

}
