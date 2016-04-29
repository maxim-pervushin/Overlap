//
// Created by Maxim Pervushin on 29/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class PickTimeViewController: UIViewController {
    
    // MARK: @IB
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickButtonAction(sender: AnyObject) {
        let components = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: datePicker.date)
        timePicked?(hours: components.hour, minutes: components.minute)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(sender: AnyObject) {
//        if let datePicker = sender as? UIDatePicker {
//            let components = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: datePicker.date)
//            print("\(components.hour):\(components.minute)")
//        }
    }

    // MARK: public

    var timePicked: ((hours: Int, minutes: Int) -> Void)?

    // MARK: private
    
    
}
