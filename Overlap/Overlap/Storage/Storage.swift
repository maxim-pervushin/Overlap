//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

protocol Storage {

    var updated: (Void -> Void)? { set get }

    var overlaps: [Overlap] { get }

    func saveOverlap(overlap: Overlap) -> Bool

    func deleteOverlap(overlap: Overlap) -> Bool
}
