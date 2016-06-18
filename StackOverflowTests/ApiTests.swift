//
//  ApiTests.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import XCTest

import Alamofire

class ApiTests: BaseCaseTest {

    func testGetListOfTags() {

        let expectation = expectationWithDescription("request should succeed")

        let URL: String = "https://api.stackexchange.com/2.2/tags?order=desc&sort=popular&site=stackoverflow"

        Alamofire.request(.GET, URL).responseJSON { response in

            print("Sucess: \(response.result.isSuccess)")

            let json = response.result.value as! NSDictionary
            let tags = json.valueForKey("items") as! NSArray

            XCTAssertNotNil(tags)

            print("tags: \(tags)")

            let list = NSMutableArray()

            for info in tags {

                let name = info.valueForKey("name") as! String

                if name.containsString("iPhone")
                    || name.containsString("Cocoa Touch")
                    || name.containsString("UiKit")
                    || name.containsString("Objective-C")
                    || name.containsString("Swift") {

                    list.addObject(name)

                }
            }

            print(list)

            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

    func testGetJSONResponse() {

        let expectation = expectationWithDescription("Alamofire")

        let URL: String = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=iOS&site=stackoverflow"

        Alamofire.request(.GET, URL).responseJSON { response in
            print("Success: \(response.result.isSuccess)")
            //            print("Response String: \(response.result.value)")

            let json = response.result.value as! NSDictionary
            let items = json.valueForKey("items") as! NSArray

            XCTAssertNotNil(items)

            print("items: \(items)")

            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)

    }

}
