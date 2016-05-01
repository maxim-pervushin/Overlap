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
    
    var interval: Interval? {
        set {
            if let newValue = newValue {
                originalTimeZone = newValue.timeZone
                timeZone = newValue.timeZone
                originalStart = newValue.start
                start = newValue.start
                originalEnd = newValue.end
                end = newValue.end
            } else {
                originalTimeZone = nil
                timeZone = nil
                originalStart = nil
                start = nil
                originalEnd = nil
                end = nil
            }
        }
        get {
            if let timeZone = timeZone, start = start, end = end {
                return Interval(timeZone: timeZone, start: start, end: end)
            } else {
                return nil
            }
        }
    }
    
    private var originalTimeZone: NSTimeZone? = nil {
        didSet {
            changed()
        }
    }
    
    private var originalStart: Int? = nil {
        didSet {
            changed()
        }
    }
    
    private var originalEnd: Int? = nil {
        didSet {
            changed()
        }
    }
    
    var hasChanges: Bool {
        return originalTimeZone != timeZone || originalStart != start || originalEnd != end
    }
    
    private func changed() {
        updated?()
    }
}
