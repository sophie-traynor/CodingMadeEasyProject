//
//  CodingMadeEasyProjectUITests.swift
//  CodingMadeEasyProjectUITests
//
//  Created by Sophie Traynor on 11/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import XCTest

class CodingMadeEasyProjectUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginSignUpSegmentedControl() {
        
       //given
        let loginSlider = app.segmentedControls.buttons["Sign In"]
        let registerSlider = app.segmentedControls.buttons["Register"]
        let loginLabel = app.staticTexts["Sign In"]
        let registerLabel = app.staticTexts["Register"]
        
        //then
        if loginSlider.isSelected{
            XCTAssertTrue(loginLabel.exists)
            XCTAssertFalse(registerLabel.exists)
            
            registerSlider.tap()
            XCTAssertTrue(registerLabel.exists)
            XCTAssertFalse(loginLabel.exists)
        } else if registerSlider.isSelected{
            XCTAssertTrue(registerLabel.exists)
            XCTAssertFalse(loginLabel.exists)
            
            loginSlider.tap()
            XCTAssertTrue(loginLabel.exists)
            XCTAssertFalse(registerLabel.exists)
        }
       
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
