//
//  ConnectTests.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import XCTest

import Alamofire

class ConnectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConnection() {
        let manager = NetworkReachabilityManager()
        let status = (manager?.isReachable)!
        XCTAssertTrue(status, "Check your network connection")
    }
    
}
