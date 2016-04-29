//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class OverlapEditor {

    private (set) var interval1Editor = IntervalEditor() {
        didSet {
            interval1Editor.updated = changed
        }
    }

    private (set) var interval2Editor = IntervalEditor() {
        didSet {
            interval1Editor.updated = changed
        }
    }

    var updated: (Void -> Void)? = nil {
        didSet {
            changed()
        }
    }

    var originalOverlap: Overlap? = nil {
        didSet {
            if let originalOverlap = originalOverlap {
                interval1Editor.originalInterval = originalOverlap.interval1
                interval2Editor.originalInterval = originalOverlap.interval2
            } else {
                interval1Editor.originalInterval = nil
                interval2Editor.originalInterval = nil
            }
        }
    }

    var updatedOverlap: Overlap? {
        guard let interval1 = interval1Editor.updatedInterval, interval2 = interval2Editor.updatedInterval else {
            return nil
        }
        return Overlap(interval1: interval1, interval2: interval2)
    }

    private func changed() {
        updated?()
    }
}
