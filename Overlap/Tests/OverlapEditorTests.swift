//
//  OverlapEditorTests.swift
//  Overlap
//
//  Created by Maxim Pervushin on 29/04/16.
//  Copyright © 2016 Maxim Pervushin. All rights reserved.
//

import XCTest
@testable import Overlap

class OverlapEditorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
/*
    func test_setOriginalOverlap() {
        let editor = OverlapEditor()
        XCTAssertNil(editor.updatedOverlap)
        XCTAssertNil(editor.interval1Editor.originalInterval)
        XCTAssertNil(editor.interval1Editor.updatedInterval)
        XCTAssertNil(editor.interval2Editor.originalInterval)
        XCTAssertNil(editor.interval2Editor.updatedInterval)

        let interval1 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)
        let interval2 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 2, end: 3)
        let overlap = Overlap(interval1: interval1, interval2: interval2)
        editor.originalOverlap = overlap

        XCTAssertNil(editor.updatedOverlap)
        XCTAssertNotNil(editor.interval1Editor.originalInterval)
        XCTAssertEqual(editor.interval1Editor.originalInterval!, interval1)
        XCTAssertNil(editor.interval1Editor.updatedInterval)
        XCTAssertNotNil(editor.interval2Editor.originalInterval)
        XCTAssertEqual(editor.interval2Editor.originalInterval!, interval2)
        XCTAssertNil(editor.interval2Editor.updatedInterval)
    }

    func test_updated() {
        var updatedFlag = false
        let editor = OverlapEditor()
        XCTAssertFalse(updatedFlag)

        editor.updated = {
            updatedFlag = true
        }
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval1Editor.start = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval1Editor.end = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval1Editor.timeZone = NSTimeZone.localTimeZone()
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        let interval1 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)
        editor.interval1Editor.originalInterval = interval1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval2Editor.start = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval2Editor.end = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.interval2Editor.timeZone = NSTimeZone.localTimeZone()
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        let interval2 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)
        editor.interval1Editor.originalInterval = interval2
        XCTAssertTrue(updatedFlag)
    }
    */
}
