//
// Created by Maxim Pervushin on 03/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class TimePickerNavigationController: UINavigationController {

    var hours: Int {
        set {
            timePickerViewController?.hours = newValue
        }
        get {
            if let timePickerViewController = timePickerViewController {
                return timePickerViewController.hours
            }
            return 0
        }
    }

    var minutes: Int {
        set {
            timePickerViewController?.minutes = newValue
        }
        get {
            if let timePickerViewController = timePickerViewController {
                return timePickerViewController.minutes
            }
            return 0
        }
    }

    var finished: (Void -> Void)? {
        set {
            timePickerViewController?.finished = newValue
        }
        get {
            return timePickerViewController?.finished
        }
    }

    private var timePickerViewController: TimePickerViewController? {
        for viewController in viewControllers {
            if let timePickerViewController = viewController as? TimePickerViewController {
                return timePickerViewController
            }
        }
        return nil
    }
}
