//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapEditorViewController: UIViewController {

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
        finished?(editor.overlap)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: AnyObject) {
        finished?(nil)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func editSourceStart(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickSourceStart, sender: self)
    }

    @IBAction func editSourceEnd(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickSourceEnd, sender: self)
    }

    @IBAction func editSourceTimezone(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickSourceTimezone, sender: self)
    }

    @IBAction func editDestinationStart(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickDestinationStart, sender: self)
    }

    @IBAction func editDestinationEnd(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickDestinationEnd, sender: self)
    }

    @IBAction func editDestinationTimezone(sender: AnyObject) {
        performSegueWithIdentifier(UIStoryboardSegue.pickDestinationTimezone, sender: self)
    }

    // MARK: public

    var overlap: Overlap? {
        set {
            if let newValue = newValue {
                editor.overlap = newValue
            } else {
                editor.overlap = Overlap.defaultOverlap()
                editor.id = nil
            }
        }
        get {
            return editor.overlap
        }
    }

    var finished: (Overlap? -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        editor.updated = reloadData

        if let overlapView = overlapView {
            sourceStartButton?.setColor(overlapView.sourceColor)
            sourceEndButton?.setColor(overlapView.sourceColor)
            sourceTimezoneButton?.setColor(overlapView.sourceColor)
            destinationStartButton?.setColor(overlapView.destinationColor)
            destinationEndButton?.setColor(overlapView.destinationColor)
            destinationTimezoneButton?.setColor(overlapView.destinationColor)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let
        timePicker = segue.destinationViewController as? TimePickerNavigationController,
        identifier = segue.identifier {
            switch identifier {
            case UIStoryboardSegue.pickSourceStart:
                if let hours = self.editor.interval1Editor.start?.hours {
                    timePicker.hours = hours
                }
                if let minutes = self.editor.interval1Editor.start?.minutes {
                    timePicker.minutes = minutes
                }
                timePicker.finished = {
                    [weak self] in
                    self?.editor.interval1Editor.start = Double(hours: timePicker.hours, minutes: timePicker.minutes)
                }
                break

            case UIStoryboardSegue.pickSourceEnd:
                if let hours = self.editor.interval1Editor.end?.hours {
                    timePicker.hours = hours
                }
                if let minutes = self.editor.interval1Editor.end?.minutes {
                    timePicker.minutes = minutes
                }
                timePicker.finished = {
                    [weak self] in
                    self?.editor.interval1Editor.end = Double(hours: timePicker.hours, minutes: timePicker.minutes)
                }
                break

            case UIStoryboardSegue.pickDestinationStart:
                if let hours = self.editor.interval2Editor.start?.hours {
                    timePicker.hours = hours
                }
                if let minutes = self.editor.interval2Editor.start?.minutes {
                    timePicker.minutes = minutes
                }
                timePicker.finished = {
                    [weak self] in
                    self?.editor.interval2Editor.start = Double(hours: timePicker.hours, minutes: timePicker.minutes)
                }
                break

            case UIStoryboardSegue.pickDestinationEnd:
                if let hours = self.editor.interval2Editor.end?.hours {
                    timePicker.hours = hours
                }
                if let minutes = self.editor.interval2Editor.end?.minutes {
                    timePicker.minutes = minutes
                }
                timePicker.finished = {
                    [weak self] in
                    self?.editor.interval2Editor.end = Double(hours: timePicker.hours, minutes: timePicker.minutes)
                }
                break

            default:
                break
            }

        } else if let
        timezonePicker = segue.destinationViewController as? TimeZonePickerNavigationController,
        identifier = segue.identifier {

            switch identifier {
            case UIStoryboardSegue.pickSourceTimezone:
                if let timeZone = self.editor.interval1Editor.timeZone {
                    timezonePicker.timeZone = timeZone
                }
                timezonePicker.finished = {
                    [weak self] in
                    self?.editor.interval1Editor.timeZone = timezonePicker.timeZone
                }
                break

            case UIStoryboardSegue.pickDestinationTimezone:
                if let timeZone = self.editor.interval2Editor.timeZone {
                    timezonePicker.timeZone = timeZone
                }
                timezonePicker.finished = {
                    [weak self] in
                    self?.editor.interval2Editor.timeZone = timezonePicker.timeZone
                }
                break

            default:
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
