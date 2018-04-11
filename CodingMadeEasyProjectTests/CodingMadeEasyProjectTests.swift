//
//  CodingMadeEasyProjectTests.swift
//  CodingMadeEasyProjectTests
//
//  Created by Sophie Traynor on 11/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import XCTest
@testable import CodingMadeEasyProject

class CodingMadeEasyProjectTests: XCTestCase {
    
    var testProfile: HomeVC!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testProfile = HomeVC()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    ///Performance
    func testUserDataProfileLoadPerformance() {
        // This is an example of a performance test case.
        
        
        self.measure {
            // Put the code you want to measure the time of here.
            self.testProfile.loadData()
        }
    }
    
}
