//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?

    private let overlaps = [
            Overlap(NSTimeZone(abbreviation: "MSK")!, 21.67, 6.5, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 20, 6, NSTimeZone(abbreviation: "GMT")!, 20, 6),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 20, 6),
//        Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 30, NSTimeZone(abbreviation: "GMT")!, 8, 17),
//        Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 24, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 8, 17, NSTimeZone(abbreviation: "GMT")!, 8, 17),
            Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17),
    ]

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let overlapEditor = segue.destinationViewController as? OverlapEditorNavigationController {
            if let indexPath = tableView?.indexPathForSelectedRow {
                overlapEditor.overlap = overlaps[indexPath.row]
            } else {
                overlapEditor.overlap = nil
            }
        }
    }
}

extension OverlapListViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? overlaps.count : 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = indexPath.section == 0 ? OverlapCell.defaultReuseIdentifier : OverlapCell.addReuseIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! OverlapCell
        cell.overlap = overlaps[indexPath.row]
        return cell
    }
}

extension OverlapListViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 110 : 50
    }
}