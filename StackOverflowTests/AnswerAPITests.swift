//
//  AnswerAPITests.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/19/16.
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
        let expectation = self.expectation(description: "should receiver succeed")

        // act
        let answerApi = AnswerAPI()
        let question_id = 37956419

        // act
        answerApi.consume(object: question_id) { (result) in
            switch result {
            case .Success(let value):
                XCTAssertNotNil(value)

                print(value)

                expectation.fulfill()

                break

            case .Failure(let error):
                XCTFail("an occured error !!! \(error)")
                expectation.fulfill()
                break
            }
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }

}
