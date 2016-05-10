import UIKit

class OverlapCell: UITableViewCell {

    // MARK: @IB

    @IBOutlet weak var sourceIntervalLabel: UILabel?
    @IBOutlet weak var destinationIntervalLabel: UILabel?
    @IBOutlet weak var overlapIntervalLabel: UILabel?
    @IBOutlet weak var overlapView: OverlapView?

    // MARK: static

    static let defaultReuseIdentifier = "OverlapCell"
    static let addReuseIdentifier = "AddOverlapCell"

    // MARK: public

    var overlap: Overlap? {
        didSet {
            overlapView?.overlap = overlap
            sourceIntervalLabel?.textColor = overlapView?.sourceColor
            destinationIntervalLabel?.textColor = overlapView?.destinationColor
            if let overlap = overlap {
                sourceIntervalLabel?.text = "\(overlap.interval1.start.timeString()) → \(overlap.interval1.end.timeString()) in \(overlap.interval1.timeZone.abbreviation!)"
                destinationIntervalLabel?.text = "\(overlap.interval2.start.timeString()) → \(overlap.interval2.end.timeString()) in \(overlap.interval2.timeZone.abbreviation!)"
            } else {
                sourceIntervalLabel?.text = ""
                destinationIntervalLabel?.text = ""
            }
        }
    }
}