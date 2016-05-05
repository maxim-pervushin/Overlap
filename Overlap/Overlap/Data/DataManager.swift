//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class DataManager {

    static let defaultManager = DataManager()

    var overlaps: [Overlap] {
        return Array(_overlapsById.values)
    }

    func saveOverlap(overlap: Overlap) -> Bool {
        _overlapsById[overlap.id] = overlap
        return true
    }

    func deleteOverlap(overlap: Overlap) -> Bool {
        _overlapsById[overlap.id] = nil
        return true
    }

    init() {
        let a = [
                Overlap(NSTimeZone(abbreviation: "MSK")!, 21.67, 6.5, NSTimeZone(abbreviation: "GMT")!, 8, 17),
//                Overlap(NSTimeZone(abbreviation: "MSK")!, 20, 6, NSTimeZone(abbreviation: "GMT")!, 20, 6),
//                Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 20, 6),
//                Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 8, 17),
//                Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17),
        ]

        for e in a {
            _overlapsById[e.id] = e
        }
    }

    private var _overlapsById = [String: Overlap]()
}
