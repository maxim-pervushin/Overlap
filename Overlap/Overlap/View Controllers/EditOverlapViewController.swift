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
        print("editSourceTimezone")
    }

    @IBAction func editDestinationStart(sender: AnyObject) {
        performSegueWithIdentifier("PickDestinationStart", sender: self)
    }

    @IBAction func editDestinationEnd(sender: AnyObject) {
        performSegueWithIdentifier("PickDestinationEnd", sender: self)
    }

    @IBAction func tapGestureOnBackgroundView(sender: AnyObject) {
        print("tapGestureOnBackgroundView")
    }

    @IBAction func editDestinationTimezone(sender: AnyObject) {
        print("editDestinationTimezone")
    }

    // MARK: public

    var overlap: Overlap? {
        didSet {
            overlapView?.overlap = overlap
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editor.updated = reloadData
//        overlap = Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17)
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
        if let updatedOverlap = editor.updatedOverlap {
            saveButton?.enabled = true
            overlapView?.overlap = updatedOverlap
        } else {
            saveButton?.enabled = true
            overlapView?.overlap = nil
        }
        
        if let sourceStartTitle = editor.interval1Editor.start {
            sourceStartButton?.setTitle("\(sourceStartTitle)", forState: .Normal)
            sourceStartButton?.setTitle("\(sourceStartTitle)", forState: .Selected)
        } else {
            sourceStartButton?.setTitle("", forState: .Normal)
            sourceStartButton?.setTitle("", forState: .Selected)
        }
        
        if let sourceEndTitle = editor.interval1Editor.start {
            sourceEndButton?.setTitle("\(sourceEndTitle)", forState: .Normal)
            sourceEndButton?.setTitle("\(sourceEndTitle)", forState: .Selected)
        } else {
            sourceEndButton?.setTitle("", forState: .Normal)
            sourceEndButton?.setTitle("", forState: .Selected)
        }
        
//        saveButton?.enabled = editor.updatedOverlap != nil
    }
}
