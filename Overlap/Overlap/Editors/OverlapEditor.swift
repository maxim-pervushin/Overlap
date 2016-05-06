//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class OverlapEditor {

    // MARK: public

    var id: String? {
        didSet {
            updated?()
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
            id = newValue?.id
            originalId = newValue?.id
            interval1Editor.interval = newValue?.interval1
            interval2Editor.interval = newValue?.interval2
        }
        get {
            if let interval1 = interval1Editor.interval, interval2 = interval2Editor.interval {
                if let id = id {
                    return Overlap(id: id, interval1: interval1, interval2: interval2)
                } else {
                    return Overlap(interval1: interval1, interval2: interval2)
                }
            } else {
                return nil
            }
        }
    }

    var hasChanges: Bool {
        return originalId != id || interval1Editor.hasChanges || interval2Editor.hasChanges
    }

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

    // MARK: private

    private var originalId: String? = nil {
        didSet {
            updated?()
        }
    }

    private func connectHandlers() {
        interval1Editor.updated = updated
        interval2Editor.updated = updated
    }
}
