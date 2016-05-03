//
//  TimeZonePickerViewController.swift
//  Overlap
//
//  Created by Maxim Pervushin on 01/05/16.
//  Copyright © 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class TimeZonePickerViewController: UIViewController {

    // MARK: @IB

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var searchBar: UISearchBar?

    @IBAction func cancelButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        finished?()
    }

    // MARK: public

    var timeZone: NSTimeZone {
        set {
            _timeZoneSet = newValue
            reloadData()
        }
        get {
            return _timeZoneSet
        }
    }

    var finished: (Void -> Void)?

    // MARK: override

    override func viewDidLoad() {
        super.viewDidLoad()

        for name in NSTimeZone.knownTimeZoneNames() {
            if let timeZone = NSTimeZone(name: name) {
                _timeZoneList.append(timeZone)
            }
        }
        updateFilter()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    // MARK: private

    private var _timeZoneSet = NSTimeZone.localTimeZone()
    private var _timeZoneList = [NSTimeZone]()
    private var _timeZoneListFiltered = [NSTimeZone]() {
        didSet {
            reloadData()
        }
    }

    private func updateFilter() {
        if let searchBar = searchBar, text = searchBar.text where text.characters.count > 0 {
            _timeZoneListFiltered = _timeZoneList.filter({
                timezone -> Bool in

                let name = timezone.name
                if name.rangeOfString(text) != nil {
                    return true
                }

                if let localizedName = timezone.localizedName(.Standard, locale: NSLocale.currentLocale()) where localizedName.rangeOfString(text) != nil {
                    return true
                }

                return false
            })
        } else {
            _timeZoneListFiltered = _timeZoneList
        }
    }

    private func reloadData() {
        tableView?.reloadData()
    }
}

extension TimeZonePickerViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _timeZoneListFiltered.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TimeZoneCell.identifier, forIndexPath: indexPath) as! TimeZoneCell
        let timezone = _timeZoneListFiltered[indexPath.row]
        if timezone == self._timeZoneSet {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        cell.timezone = timezone
        return cell
    }
}

extension TimeZonePickerViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let
        cell = tableView.cellForRowAtIndexPath(indexPath) as? TimeZoneCell,
        timezone = cell.timezone {
            self.timeZone = timezone
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension TimeZonePickerViewController: UISearchBarDelegate {

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilter()
    }
}