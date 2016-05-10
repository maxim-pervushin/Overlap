//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import XCTest
@testable import Overlap

class IntervalEditorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    /*
    func test_setOriginalInterval() {
        let editor = IntervalEditor()
        XCTAssertNil(editor.timeZone)
        XCTAssertNil(editor.start)
        XCTAssertNil(editor.end)

        let interval = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)
        editor.originalInterval = interval
        XCTAssertEqual(editor.timeZone, interval.timeZone)
        XCTAssertEqual(editor.start, interval.start)
        XCTAssertEqual(editor.end, interval.end)

        editor.originalInterval = nil
        XCTAssertNil(editor.timeZone)
        XCTAssertNil(editor.start)
        XCTAssertNil(editor.end)
    }

    func test_updatedInterval_nilOriginalInterval() {
        let editor = IntervalEditor()
        XCTAssertNil(editor.updatedInterval)

        let interval = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)

        editor.timeZone = interval.timeZone
        XCTAssertNil(editor.updatedInterval)

        editor.start = interval.start
        XCTAssertNil(editor.updatedInterval)

        editor.end = interval.end
        XCTAssertNotNil(editor.updatedInterval)
        XCTAssertEqual(editor.updatedInterval!, interval)
    }

    func test_updatedInterval_originalInterval() {
        let editor = IntervalEditor()
        XCTAssertNil(editor.updatedInterval)

        let interval = Interval(timeZone: NSTimeZone.localTimeZone(), start: 1, end: 2)

        editor.originalInterval = interval
        XCTAssertNil(editor.updatedInterval)

        editor.start = 2
        XCTAssertNotNil(editor.updatedInterval)
        XCTAssertNotEqual(editor.updatedInterval!, interval)
    }

    func test_updated() {
        var updatedFlag = false
        let editor = IntervalEditor()
        XCTAssertFalse(updatedFlag)

        editor.updated = {
            updatedFlag = true
        }
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.start = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.end = 1
        XCTAssertTrue(updatedFlag)

        updatedFlag = false
        editor.timeZone = NSTimeZone.localTimeZone()
        XCTAssertTrue(updatedFlag)
    }
    */
}
