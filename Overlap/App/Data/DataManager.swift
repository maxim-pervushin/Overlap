//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class DataManager {

    static let updatedNotificationName = "DataManagerUpdatedNotification"
    // static let defaultManager = DataManager(storage: PlistStorage())

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

        if _isFirstLaunch {
            saveOverlap(Overlap.defaultOverlap())
        }
    }

    static private let _firstLaunchDateDefaultsKey = "FirstLaunchDate"
    private let _storage: Storage
    private var _overlapsById = [String: Overlap]()
    private var _isFirstLaunch: Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        let firstLaunchDate  = defaults.doubleForKey(DataManager._firstLaunchDateDefaultsKey)
        if firstLaunchDate > 0 {
            return false
        } else {
            defaults.setDouble(NSDate().timeIntervalSince1970, forKey: DataManager._firstLaunchDateDefaultsKey)
            defaults.synchronize()
            return true
        }
    }

    private func _updated() {
        NSNotificationCenter.defaultCenter().postNotificationName(DataManager.updatedNotificationName, object: self)
    }

}
