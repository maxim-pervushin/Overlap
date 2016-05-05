import Foundation

struct Overlap {

    let id: String
    let interval1: Interval
    let interval2: Interval

    init(interval1: Interval, interval2: Interval) {
        self.init(id: NSUUID().UUIDString, interval1: interval1, interval2: interval2)
    }

    init(id: String, interval1: Interval, interval2: Interval) {
        self.id = id
        self.interval1 = interval1
        self.interval2 = interval2
    }

    init(_ timeZone1: NSTimeZone, _ interval1Start: Double, _ interval1End: Double, _ timeZone2: NSTimeZone, _ interval2Start: Double, _ interval2End: Double) {
        let id = NSUUID().UUIDString
        let interval1 = Interval(timeZone: timeZone1, start: interval1Start, end: interval1End)
        let interval2 = Interval(timeZone: timeZone2, start: interval2Start, end: interval2End)
        self.init(id: id, interval1: interval1, interval2: interval2)
    }

    init(_ id: String, _ timeZone1: NSTimeZone, _ interval1Start: Double, _ interval1End: Double, _ timeZone2: NSTimeZone, _ interval2Start: Double, _ interval2End: Double) {
        let interval1 = Interval(timeZone: timeZone1, start: interval1Start, end: interval1End)
        let interval2 = Interval(timeZone: timeZone2, start: interval2Start, end: interval2End)
        self.init(id: id, interval1: interval1, interval2: interval2)
    }

    func overlapIntervalsInTimeZone(timeZone: NSTimeZone) -> [Interval] {
        var result = [Interval]()
        for i1 in interval1.adjustedIntervalsInTimeZone(timeZone) {
            for i2 in interval2.adjustedIntervalsInTimeZone(timeZone) {
                let start = max(i1.start, i2.start)
                let end = min(i1.end, i2.end)
                if start < end {
                    result.append(Interval(timeZone: timeZone, start: start, end: end))
                }
            }
        }
        return result
    }
}

extension Overlap {

    static func defaultOverlap() -> Overlap {
        let interval1 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 8, end: 17)
        let interval2 = Interval(timeZone: NSTimeZone.localTimeZone(), start: 9, end: 18)
        return Overlap(interval1: interval1, interval2: interval2)
    }
}