//
// Created by Maxim Pervushin on 03/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class TimeZonePickerNavigationController: UINavigationController {

    var timeZone: NSTimeZone {
        set {
            timezonePickerViewController?.timeZone = newValue
        }
        get {
            if let timezone = timezonePickerViewController?.timeZone {
                return timezone
            }
            return NSTimeZone.localTimeZone()
        }
    }

    var finished: (Void -> Void)? {
        set {
            timezonePickerViewController?.finished = newValue
        }
        get {
            return timezonePickerViewController?.finished
        }
    }

    private var timezonePickerViewController: TimeZonePickerViewController? {
        for viewController in viewControllers {
            if let timezonePickerViewController = viewController as? TimeZonePickerViewController {
                return timezonePickerViewController
            }
        }
        return nil
    }
}
