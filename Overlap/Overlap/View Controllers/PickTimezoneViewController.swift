//
//  PickTimezoneViewController.swift
//  Overlap
//
//  Created by Maxim Pervushin on 01/05/16.
//  Copyright © 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class PickTimezoneViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for name in NSTimeZone.knownTimeZoneNames() {
            //print("\(name)")
            if let timeZone = NSTimeZone(name: name) {
                data.append(timeZone)
            }
        }
    }

    private var data = [NSTimeZone]() {
        didSet {
            tableView?.reloadData()
        }
    }
}

extension PickTimezoneViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimezoneCell", forIndexPath: indexPath)
        let timezone = data[indexPath.row]
        cell.textLabel?.text = timezone.name // timezone.localizedName(.Standard, locale: NSLocale.currentLocale())
        cell.detailTextLabel?.text = timezone.localizedName(.Standard, locale: NSLocale.currentLocale())
        return cell
    }
}
