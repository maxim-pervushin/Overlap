//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapListViewController: UIViewController {

    // MARK: @IB

    @IBOutlet weak var tableView: UITableView?

    // MARK: override

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let overlapEditor = segue.destinationViewController as? OverlapEditorNavigationController {
            overlapEditor.finished = {
                (overlap: Overlap?) in
                if let overlap = overlap {
                    if self._saveOverlap(overlap) {
                        self.tableView?.reloadData()
                    }
                }
            }
            if let indexPath = tableView?.indexPathForSelectedRow where indexPath.section == 0 {
                overlapEditor.overlap = _overlaps[indexPath.row]
            } else {
                overlapEditor.overlap = nil
            }
        }
    }

    // MARK: private

    private var _overlaps: [Overlap] {
        return DataManager.defaultManager.overlaps
    }

    private func _deleteOverlap(overlap: Overlap) -> Bool {
        return DataManager.defaultManager.deleteOverlap(overlap)
    }

    private func _saveOverlap(overlap: Overlap) -> Bool {
        return DataManager.defaultManager.saveOverlap(overlap)
    }
}

extension OverlapListViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? _overlaps.count : 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = indexPath.section == 0 ? OverlapCell.defaultReuseIdentifier : OverlapCell.addReuseIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! OverlapCell
        if indexPath.section == 0 {
            cell.overlap = _overlaps[indexPath.row]
        } else {
            cell.overlap = nil
        }
        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if .Delete == editingStyle {
            if _deleteOverlap(_overlaps[indexPath.row]) {
                self.tableView?.reloadData()
            }
        }
    }
}

extension OverlapListViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 0 ? 110 : 50
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return indexPath.section == 0 ? .Delete : .None
    }
}