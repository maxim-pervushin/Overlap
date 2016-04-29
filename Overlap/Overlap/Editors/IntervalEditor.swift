//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class IntervalEditor {

    var timeZone: NSTimeZone? = nil {
        didSet {
            changed()
        }
    }

    var start: Int? = nil {
        didSet {
            changed()
        }
    }

    var end: Int? = nil {
        didSet {
            changed()
        }
    }

    var updated: (Void -> Void)? = nil {
        didSet {
            changed()
        }
    }

    var originalInterval: Interval? = nil {
        didSet {
            if let originalInterval = originalInterval {
                timeZone = originalInterval.timeZone
                start = originalInterval.start
                end = originalInterval.end
            } else {
                timeZone = nil
                start = nil
                end = nil
            }
        }
    }

    var updatedInterval: Interval? {
        guard let timeZone = timeZone, start = start, end = end else {
            return nil
        }
        if let originalInterval = originalInterval where timeZone == originalInterval.timeZone && start == originalInterval.start && end == originalInterval.end {
            return nil
        }

        return Interval(timeZone: timeZone, start: start, end: end)
    }

    private func changed() {
        updated?()
    }
}
