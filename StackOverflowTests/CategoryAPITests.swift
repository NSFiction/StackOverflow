//
//  CategoryAPITests.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 7/5/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import XCTest

@testable import StackOverflow

class CategoryAPITests: BaseCaseTest {

    /* requisite:
     *
     *    Get all categories
     *
     */
    func testCategory() {

        let expectation = expectationWithDescription("should received success")

        // arrange
        let category = CategoryAPI()

        // act
        category.consume { (result) in
            // assert
            XCTAssertNotNil(result)

            switch result {
            case .Success(let value):

                XCTAssertNotNil(value)
                print(value)
                break

            case .Failure(let error):
                XCTFail("an occured error !!! \(error)")
                break
            }

            expectation.fulfill()

        }

        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

}
