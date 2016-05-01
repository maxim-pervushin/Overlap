//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class EditOverlapViewController: UIViewController {

    // MARK: @IB

    @IBOutlet weak var saveButton: UIBarButtonItem?
    @IBOutlet weak var overlapView: OverlapView?
    
    @IBOutlet weak var sourceStartButton: UIButton?
    @IBOutlet weak var sourceEndButton: UIButton?
    @IBOutlet weak var sourceTimezoneButton: UIButton?
    @IBOutlet weak var destinationStartButton: UIButton?
    @IBOutlet weak var destinationEndButton: UIButton?
    @IBOutlet weak var destinationTimezoneButton: UIButton?

    @IBAction func save(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func editSourceStart(sender: AnyObject) {
        performSegueWithIdentifier("PickSourceStart", sender: self)
    }

    @IBAction func editSourceEnd(sender: AnyObject) {
        performSegueWithIdentifier("PickSourceEnd", sender: self)
    }

    @IBAction func editSourceTimezone(sender: AnyObject) {
        performSegueWithIdentifier("PickSourceTimezone", sender: self)
    }

    @IBAction func editDestinationStart(sender: AnyObject) {
        performSegueWithIdentifier("PickDestinationStart", sender: self)
    }

    @IBAction func editDestinationEnd(sender: AnyObject) {
        performSegueWithIdentifier("PickDestinationEnd", sender: self)
    }

    @IBAction func editDestinationTimezone(sender: AnyObject) {
        performSegueWithIdentifier("PickDestinationTimezone", sender: self)
    }

    // MARK: public

    var overlap: Overlap? {
        set {
            editor.overlap = newValue
        }
        get {
            return editor.overlap
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editor.updated = reloadData
        overlap = Overlap.defaultOverlap()
//        reloadData()
        
        if let overlapView = overlapView {
            sourceStartButton?.setTitleColor(overlapView.sourceColor)
            sourceEndButton?.setTitleColor(overlapView.sourceColor)
            sourceTimezoneButton?.setTitleColor(overlapView.sourceColor)
            destinationStartButton?.setTitleColor(overlapView.destinationColor)
            destinationEndButton?.setTitleColor(overlapView.destinationColor)
            destinationTimezoneButton?.setTitleColor(overlapView.destinationColor)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let
        pickTimeViewController = segue.destinationViewController as? PickTimeViewController,
        identifier = segue.identifier {
            switch identifier {
            case "PickSourceStart":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval1Editor.start = hours
                }
                break
            case "PickSourceEnd":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval1Editor.end = hours
                }
                break
            case "PickDestinationStart":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval2Editor.start = hours
                }
                break
            case "PickDestinationEnd":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval2Editor.end = hours
                }
                break
            default:
                pickTimeViewController.timePicked = nil
            break
            }
        }
    }

    // MARK: private

    private let editor = OverlapEditor()

    private func reloadData() {
        saveButton?.enabled = editor.hasChanges

        overlapView?.overlap = overlap
        
        if let sourceStartTitle = editor.interval1Editor.start {
            sourceStartButton?.setTitle("\(sourceStartTitle)")
        } else {
            sourceStartButton?.setTitle("")
        }
        
        if let sourceEndTitle = editor.interval1Editor.end {
            sourceEndButton?.setTitle("\(sourceEndTitle)")
        } else {
            sourceEndButton?.setTitle("")
        }
        
        if let
            sourceTimeZone = editor.interval1Editor.timeZone,
            localizedName = sourceTimeZone.localizedName(.Generic, locale: NSLocale.currentLocale()) {
            sourceTimezoneButton?.setTitle(localizedName)
        } else {
            sourceTimezoneButton?.setTitle("")
        }
        
        if let destinationStartTitle = editor.interval2Editor.start {
            destinationStartButton?.setTitle("\(destinationStartTitle)")
        } else {
            destinationStartButton?.setTitle("")
        }
        
        if let destinationEndTitle = editor.interval2Editor.end {
            destinationEndButton?.setTitle("\(destinationEndTitle)")
        } else {
            destinationEndButton?.setTitle("")
        }
        
        if let
            destinationTimeZone = editor.interval2Editor.timeZone,
            localizedName = destinationTimeZone.localizedName(.Generic, locale: NSLocale.currentLocale()) {
            destinationTimezoneButton?.setTitle(localizedName)
        } else {
            destinationTimezoneButton?.setTitle("")
        }
    }
}

extension UIButton {
    
    func setTitle(title: String) {
        setTitle(title, forState: .Normal)
        setTitle(title, forState: .Selected)
        setTitle(title, forState: .Disabled)
        setTitle(title, forState: .Highlighted)
        setTitle(title, forState: .Focused)
    }
    
    func setTitleColor(color: UIColor) {
        setTitleColor(color, forState: .Normal)
        setTitleColor(color, forState: .Selected)
        setTitleColor(color, forState: .Disabled)
        setTitleColor(color, forState: .Highlighted)
        setTitleColor(color, forState: .Focused)
    }
}
