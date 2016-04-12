//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapListViewController: UITableViewController {

    private let overlaps = [
            Overlap(NSTimeZone(abbreviation: "MSK")!, 20, 6, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 20, 6, NSTimeZone(abbreviation: "GMT")!, 20, 6),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 20, 6),
//        Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 30, NSTimeZone(abbreviation: "GMT")!, 8, 17),
//        Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 24, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17),
    ]

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return overlaps.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(OverlapCell.defaultReuseIdentifier, forIndexPath: indexPath) as! OverlapCell
        cell.overlap = overlaps[indexPath.row]
        return cell
    }
}
