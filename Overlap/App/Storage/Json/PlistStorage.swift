//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

class PlistStorage {

    private var _updated: (Void -> Void)?

    private var _overlapsById: [String:Overlap] = [:] {
        didSet {
            _updated?()
        }
    }

    private func _filePath() -> String {
        if let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            return path + "/overlaps.plist"
        }
        // TODO: Write error somewhere
        return ""
    }

    private func _load() {
        guard let arr = NSArray(contentsOfFile: _filePath()) as? [[String:AnyObject]] else {
            _overlapsById = [:]
            return
        }

        var overlapsById = [String: Overlap]()
        for overlapDictionary in arr {
            if let overlap = Overlap(dictionary: overlapDictionary) {
                overlapsById[overlap.id] = overlap
            }
        }
        _overlapsById = overlapsById
    }

    private func _save() {
        var serialized = [[String: AnyObject]]()
        for (_, overlap) in _overlapsById {
            serialized.append(overlap.serializeToDictionary())
        }

        if !(serialized as NSArray).writeToFile(_filePath(), atomically: true) {
            // TODO: Write error somewhere
        }
    }

    init() {
        _load()
    }
}

extension PlistStorage: Storage {

    var updated: (Void -> Void)? {
        set {
            _updated = newValue
        }
        get {
            return _updated
        }
    }

    var overlaps: [Overlap] {
        return Array(_overlapsById.values)
    }

    func saveOverlap(overlap: Overlap) -> Bool {
        _overlapsById[overlap.id] = overlap
        _save()
        return true
    }

    func deleteOverlap(overlap: Overlap) -> Bool {
        _overlapsById[overlap.id] = nil
        _save()
        return true
    }
}