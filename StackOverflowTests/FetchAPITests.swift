//
//  FetchAPITests.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/21/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import XCTest

@testable import StackOverflow

class FetchAPITests: BaseCaseTest {

    /* requisite:
     *
     *    fetch api with function generic
     *
     */
    func testFetchAPI_Answer() {

        let expectation = expectationWithDescription("request should succeed")

        // arrange
        let consumeAPI = ConsumeAnswer()
        let question_id = 37956419//11227809

        // act
        consumeAPI.fetch(question_id) { (result) in
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

        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

}
