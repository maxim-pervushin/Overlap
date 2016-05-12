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
        let app = XCUIApplication()
        
        let addButton = app.buttons.matchingIdentifier("Add") // ["Add"]
        addButton.element.tap()
        
        let saveButton = app.buttons.matchingIdentifier("Save") // ["Save"]
        if 0 == saveButton.count {
            addButton.element.tap()
        }
        
        snapshot("02_Editor")
        
        saveButton.element.tap()
        if 0 == addButton.count {
            saveButton.element.tap()
        }

        snapshot("01_List")
    }
}
