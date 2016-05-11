//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class DataManager {

    static let updatedNotificationName = "DataManagerUpdatedNotification"
    static let defaultManager = DataManager(storage: PlistStorage())

    var overlaps: [Overlap] {
        return _storage.overlaps
    }

    func saveOverlap(overlap: Overlap) -> Bool {
        return _storage.saveOverlap(overlap)
    }

    func deleteOverlap(overlap: Overlap) -> Bool {
        return _storage.deleteOverlap(overlap)
    }

    init(storage: Storage) {
        self._storage = storage
        self._storage.updated = {
            [weak self] in
            self?._updated()
        }
//        let a = [
//                Overlap(NSTimeZone(abbreviation: "MSK")!, 21.67, 6.5, NSTimeZone(abbreviation: "GMT")!, 8, 17),
////                Overlap(NSTimeZone(abbreviation: "MSK")!, 20, 6, NSTimeZone(abbreviation: "GMT")!, 20, 6),
////                Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 20, 6),
////                Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 8, 17),
////                Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17),
//        ]
//
//        for e in a {
//            _overlapsById[e.id] = e
//        }
    }

    private let _storage: Storage
    private var _overlapsById = [String: Overlap]()

    private func _updated() {
        NSNotificationCenter.defaultCenter().postNotificationName(DataManager.updatedNotificationName, object: self)
    }
}
