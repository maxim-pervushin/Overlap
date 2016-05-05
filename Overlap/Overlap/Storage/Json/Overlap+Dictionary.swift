//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

extension Overlap {

    func serializeToDictionary() -> [String:AnyObject] {
        return [
                "id": id,
                "interval1": interval1.serializeToDictionary(),
                "interval2": interval2.serializeToDictionary()
        ]
    }

    init?(dictionary: [String:AnyObject]) {
        guard let id = dictionary["id"] as? String else {
            return nil
        }

        guard let
        interval1Dictionary = dictionary["interval1"] as? [String:AnyObject],
        interval1 = Interval(dictionary: interval1Dictionary)
        else {
            return nil
        }

        guard let
        interval2Dictionary = dictionary["interval2"] as? [String:AnyObject],
        interval2 = Interval(dictionary: interval2Dictionary)
        else {
            return nil
        }

        self.init(id: id, interval1: interval1, interval2: interval2)
    }
}
