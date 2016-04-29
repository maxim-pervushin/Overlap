import Foundation

struct Overlap {
    let interval1: Interval
    let interval2: Interval

    init(interval1: Interval, interval2: Interval) {
        self.interval1 = interval1
        self.interval2 = interval2
    }

    init(_ timeZone1: NSTimeZone, _ interval1Start: Int, _ interval1End: Int, _ timeZone2: NSTimeZone, _ interval2Start: Int, _ interval2End: Int) {
        let interval1 = Interval(timeZone: timeZone1, start: interval1Start, end: interval1End)
        let interval2 = Interval(timeZone: timeZone2, start: interval2Start, end: interval2End)
        self.init(interval1: interval1, interval2: interval2)
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
