//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class EditOverlapViewController: UIViewController {

    // MARK: @IB

    @IBOutlet weak var saveButton: UIBarButtonItem?
    @IBOutlet weak var overlapView: OverlapView?
    
    @IBOutlet weak var sourceStartButton: EditButton?
    @IBOutlet weak var sourceEndButton: EditButton?
    @IBOutlet weak var sourceTimezoneButton: EditButton?
    @IBOutlet weak var destinationStartButton: EditButton?
    @IBOutlet weak var destinationEndButton: EditButton?
    @IBOutlet weak var destinationTimezoneButton: EditButton?

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
//            let sourceBackgroundColor = overlapView.sourceColor.colorWithAlphaComponent(0.3)

            sourceStartButton?.setColor(overlapView.sourceColor)
            sourceEndButton?.setColor(overlapView.sourceColor)
            sourceTimezoneButton?.setColor(overlapView.sourceColor)

//            sourceEndButton?.backgroundColor = sourceBackgroundColor
//            sourceEndButton?.setTitleColor(overlapView.sourceColor)
//            sourceTimezoneButton?.backgroundColor = sourceBackgroundColor
//            sourceTimezoneButton?.setTitleColor(overlapView.sourceColor)

//            let destinationBackgroundColor = overlapView.destinationColor.colorWithAlphaComponent(0.3)
            destinationStartButton?.setColor(overlapView.destinationColor)
            destinationEndButton?.setColor(overlapView.destinationColor)
            destinationTimezoneButton?.setColor(overlapView.destinationColor)
//            destinationStartButton?.backgroundColor = destinationBackgroundColor
//            destinationStartButton?.setTitleColor(overlapView.destinationColor)
//            destinationEndButton?.backgroundColor = destinationBackgroundColor
//            destinationEndButton?.setTitleColor(overlapView.destinationColor)
//            destinationTimezoneButton?.backgroundColor = destinationBackgroundColor
//            destinationTimezoneButton?.setTitleColor(overlapView.destinationColor)
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
                    self.editor.interval1Editor.start = Double(hours * 60 + minutes)
                }
                break
            case "PickSourceEnd":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval1Editor.end = Double(hours * 60 + minutes)
                }
                break
            case "PickDestinationStart":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval2Editor.start = Double(hours * 60 + minutes)
                }
                break
            case "PickDestinationEnd":
                pickTimeViewController.timePicked = {
                    (hours: Int, minutes: Int) -> Void in
                    self.editor.interval2Editor.end = Double(hours * 60 + minutes)
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
        
        if let sourceStartTitle = editor.interval1Editor.start?.timeString() {
            sourceStartButton?.setTitle("\(sourceStartTitle)")
        } else {
            sourceStartButton?.setTitle("")
        }
        
        if let sourceEndTitle = editor.interval1Editor.end?.timeString() {
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
        
        if let destinationStartTitle = editor.interval2Editor.start?.timeString() {
            destinationStartButton?.setTitle("\(destinationStartTitle)")
        } else {
            destinationStartButton?.setTitle("")
        }
        
        if let destinationEndTitle = editor.interval2Editor.end?.timeString() {
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
