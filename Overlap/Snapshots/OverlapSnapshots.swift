//
//  OverlapSnapshots.swift
//  OverlapSnapshots
//
//  Created by Maxim Pervushin on 10/05/16.
//  Copyright © 2016 Maxim Pervushin. All rights reserved.
//

import XCTest

class OverlapSnapshots: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_MakeSnapshots() {
        snapshot("01_Start")
        
        let app = XCUIApplication()
        app.buttons["Add"].tap()
        
        snapshot("02_Editor")
        
        app.buttons["Save"].tap()

        snapshot("03_List")
    }
    
}
