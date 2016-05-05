//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

extension Interval {

    func serializeToDictionary() -> [String:AnyObject] {
        return [
                "timeZone": timeZone.name,
                "start": start,
                "end": end,
        ]
    }

    init?(dictionary: [String:AnyObject]) {
        guard let timeZoneName = dictionary["timeZone"] as? String, timeZone1 = NSTimeZone(name: timeZoneName) else {
            return nil
        }

        guard let start1 = dictionary["start"] as? Double else {
            return nil
        }

        guard let end1 = dictionary["end"] as? Double else {
            return nil
        }

        self.init(timeZone: timeZone1, start: start1, end: end1)
    }
}
