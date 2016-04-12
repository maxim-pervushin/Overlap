import UIKit

class OverlapCell: UITableViewCell {

    // MARK: @IB

    @IBOutlet weak var sourceIntervalLabel: UILabel?
    @IBOutlet weak var destinationIntervalLabel: UILabel?
    @IBOutlet weak var overlapIntervalLabel: UILabel?
    @IBOutlet weak var overlapView: OverlapView?

    // MARK: static

    static let defaultReuseIdentifier = "OverlapCell"

    // MARK: public

    var overlap: Overlap? {
        didSet {
            overlapView?.overlap = overlap
            sourceIntervalLabel?.textColor = overlapView?.sourceColor
            destinationIntervalLabel?.textColor = overlapView?.destinationColor
            if let overlap = overlap {
                sourceIntervalLabel?.text = "\(overlap.interval1.start) → \(overlap.interval1.end) in \(overlap.interval1.timeZone.abbreviation!)"
                destinationIntervalLabel?.text = "\(overlap.interval2.start) → \(overlap.interval2.end) in \(overlap.interval2.timeZone.abbreviation!)"
            } else {
                sourceIntervalLabel?.text = ""
                destinationIntervalLabel?.text = ""
            }
        }
    }
}
