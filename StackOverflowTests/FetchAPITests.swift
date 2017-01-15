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
     *    Answer - fetch api with function generic
     *
     */
    func testFetchAPI_Answer() {

        let expectation = self.expectation(description: "request should succeed")

        // arrange
        let consumeAPI = ConsumeAnswer()
        let question_id = 37956419//11227809

        // act
        consumeAPI.fetch(question_id) { (result) in
            switch result {
            case .Success(let value):

                // assert
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

    /* requisite:
     *
     *    Question - fetch api with function generic
     *
     */
    func testFetchAPI_Question() {

        let expectation = self.expectation(description: "request should succeed")

        // arrange
        let consumeAPI = ConsumeQuestion()
        let category = "Swift"

        // act
        consumeAPI.fetch(category) { (result) in
            switch result {
            case .Success(let value):

                // assert
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
