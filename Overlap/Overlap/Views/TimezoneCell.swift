//
// Created by Maxim Pervushin on 03/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class TimeZoneCell: UITableViewCell {

    static let identifier = "TimeZoneCell"

    var timezone: NSTimeZone? {
        didSet {
            if let timezone = timezone {
                textLabel?.text = timezone.localizedName(.Standard, locale: NSLocale.currentLocale())
                detailTextLabel?.text = timezone.name
            } else {
                textLabel?.text = ""
                detailTextLabel?.text = ""
            }
        }
    }
}
