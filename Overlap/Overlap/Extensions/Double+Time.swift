//
// Created by Maxim Pervushin on 02/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

extension Double {

    init(hours: Int, minutes: Int) {
        self = Double(hours) + Double(minutes) / 60
    }

    func timeString() -> String {
        // TODO: Should take in account NSLocale, AM/PM
        let hours = Int(self)
        let minutes = (self - Double(hours)) * 60
        // TODO: Find better solution
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        return String(format: "%d:%@", hours, formatter.stringFromNumber(minutes)!)
    }

    var hours: Int {
        return Int(self)
    }

    var minutes: Int {
        let hours = Int(self)
        return Int((self - Double(hours)) * 60)
    }
}