//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class OverlapEditor {

    private (set) var interval1Editor = IntervalEditor() {
        didSet {
            connectHandlers()
        }
    }

    private (set) var interval2Editor = IntervalEditor() {
        didSet {
            connectHandlers()
        }
    }

    var updated: (Void -> Void)? = nil {
        didSet {
            connectHandlers()
            updated?()
        }
    }

    var overlap: Overlap? {
        set {
            interval1Editor.interval = newValue?.interval1
            interval2Editor.interval = newValue?.interval2
        }
        get {
            if let interval1 = interval1Editor.interval, interval2 = interval2Editor.interval {
                return Overlap(interval1: interval1, interval2: interval2)
            } else {
                return nil
            }
        }
    }
    
    var hasChanges: Bool {
        return interval1Editor.hasChanges || interval2Editor.hasChanges
    }

    private func connectHandlers() {
        interval1Editor.updated = updated
        interval2Editor.updated = updated
    }
}
