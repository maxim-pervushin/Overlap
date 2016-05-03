//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class TimePickerViewController: UIViewController {

    // MARK: @IB

    @IBOutlet weak var datePicker: UIDatePicker?

    @IBAction func cancelButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickButtonAction(sender: AnyObject) {
        guard let _ = datePicker?.date else {
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        dismissViewControllerAnimated(true, completion: nil)
        finished?()
    }

    // MARK: public

    var hours: Int {
        set {
            _hoursSet = newValue
            reloadData()
        }
        get {
            guard let date = datePicker?.date else {
                return 0
            }
            let components = NSCalendar.currentCalendar().components([.Hour], fromDate: date)
            return components.hour
        }
    }

    var minutes: Int {
        set {
            _minutesSet = newValue
            reloadData()
        }
        get {
            guard let date = datePicker?.date else {
                return 0
            }
            let components = NSCalendar.currentCalendar().components([.Minute], fromDate: date)
            return components.minute
        }
    }

    var finished: (Void -> Void)?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: workaround for UIDatePicker text color. http://stackoverflow.com/questions/20181225/customize-text-color-of-uidatepicker-for-ios7-just-like-mailbox-does
        datePicker?.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
    }

    // MARK: private

    private func reloadData() {
        guard let datePicker = datePicker else {
            return
        }
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: datePicker.date)
        components.hour = _hoursSet
        components.minute = _minutesSet
        if let newDate = calendar.dateFromComponents(components) {
            datePicker.setDate(newDate, animated: false)
        }
    }

    private var _hoursSet = 0
    private var _minutesSet = 0
}
