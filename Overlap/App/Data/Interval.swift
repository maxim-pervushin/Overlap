import Foundation

public struct Interval: Equatable {
    let timeZone: NSTimeZone
    let start: Double
    let end: Double
    
    init(timeZone: NSTimeZone, start: Double, end: Double) {
        self.timeZone = timeZone
        self.start = start < 0 ? 0 : start
        self.end = end > 24 ? 24 : end
    }
    
    func intervalInTimeZone(timeZone: NSTimeZone) -> Interval {
        let sourceOffset = Double(self.timeZone.secondsFromGMT) / 60 / 60
        let targetOffset = Double(timeZone.secondsFromGMT) / 60 / 60
        return Interval(timeZone: timeZone, start: start - sourceOffset + targetOffset, end: end - sourceOffset + targetOffset)
    }
    
    var adjustedIntervals: [Interval] {
        return adjustedIntervalsInTimeZone(timeZone)
    }
    
    func adjustedIntervalsInTimeZone(timeZone: NSTimeZone) -> [Interval] {
        if start <= end {
            return [self.intervalInTimeZone(timeZone)]
        } else {
            let interval = self.intervalInTimeZone(timeZone)
            return [
                Interval(timeZone: interval.timeZone, start: 0, end: interval.end),
                Interval(timeZone: interval.timeZone, start: interval.start, end: 24)
            ]
        }
    }
}

public func ==(lhs: Interval, rhs: Interval) -> Bool {
    return lhs.timeZone == rhs.timeZone && lhs.start == rhs.start && lhs.end == rhs.end
}
