import UIKit

@IBDesignable class OverlapView: UIView {

    @IBInspectable var sourceColor = UIColor(red: 0.91, green: 0.29, blue: 0.21, alpha: 1.00)
    @IBInspectable var destinationColor = UIColor(red: 0.13, green: 0.50, blue: 0.73, alpha: 1.00)
    @IBInspectable var overlapColor = UIColor(red: 0.06, green: 0.69, blue: 0.41, alpha: 1.00)
    @IBInspectable var rulerColor = UIColor(red: 0.74, green: 0.76, blue: 0.78, alpha: 1.00)

    var overlap: Overlap? {
        didSet {
//            backgroundColor = UIColor.clearColor()
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        let ctx = UIGraphicsGetCurrentContext()

        let topOffest = CGFloat(2)
        let bottomOffest = CGFloat(2)
        let height = bounds.height - topOffest - bottomOffest
//        let rowHeight = height / 3

        let startOffest = CGFloat(8)
        let endOffest = CGFloat(8)

        let width = bounds.width - startOffest - endOffest

        let start = 0
        let end = 24
        let count = CGFloat(end - start)

        func drawRuler() {
            CGContextSetLineWidth(ctx, 1 / UIScreen.mainScreen().scale)
            CGContextSetStrokeColorWithColor(ctx, rulerColor.CGColor)

            let textAttributes = [
                    NSForegroundColorAttributeName: rulerColor,
                    NSFontAttributeName: UIFont.monospacedDigitSystemFontOfSize(8, weight: 0)// systemFontOfSize(8)
            ]

            for i in 0.stride(through: end - start, by: 1) {
                let x = CGFloat(i) * width / count + startOffest

                if 0 == i % 6 {
                    let text = NSString(string: "\(i)")
                    let size = text.sizeWithAttributes(textAttributes)

                    text.drawAtPoint(CGPoint(x: x - size.width / 2, y: 0), withAttributes: textAttributes)
                }
//                CGContextMoveToPoint(ctx, x, 0)
//                CGContextAddLineToPoint(ctx, x, 2)

                CGContextMoveToPoint(ctx, x, height / 6 * 1.5)
                CGContextAddLineToPoint(ctx, x, height / 6 * 2)
            }
            CGContextStrokePath(ctx)
        }

        drawRuler()

        if let overlap = overlap {

            let targetTimeZone = overlap.interval2.timeZone

            func drawIndicatorWithColor(color: UIColor, startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {

                CGContextSetLineWidth(ctx, 2 / UIScreen.mainScreen().scale)
                CGContextSetStrokeColorWithColor(ctx, color.CGColor)

                CGContextMoveToPoint(ctx, startX + 1, startY)
                CGContextAddLineToPoint(ctx, endX - 1, endY)
                CGContextStrokePath(ctx)

                CGContextStrokeEllipseInRect(ctx, CGRect(x: startX - 1, y: startY - 1, width: 2, height: 2))
                CGContextStrokeEllipseInRect(ctx, CGRect(x: endX - 1, y: endY - 1, width: 2, height: 2))
            }

            func drawOverlap(startX: CGFloat, endX: CGFloat, startText: String, endText: String) {
                CGContextSetLineWidth(ctx, 2 / UIScreen.mainScreen().scale)
                CGContextSetFillColorWithColor(ctx, overlapColor.colorWithAlphaComponent(0.25).CGColor)
                CGContextSetStrokeColorWithColor(ctx, overlapColor.CGColor)
                CGContextFillRect(ctx, CGRect(x: startX, y: height / 6 * 3, width: endX - startX, height: height / 6 * 2))

                CGContextMoveToPoint(ctx, startX, height / 6 * 3)
                CGContextAddLineToPoint(ctx, startX, height - height / 6 - 1)
                CGContextStrokePath(ctx)

                CGContextStrokeEllipseInRect(ctx, CGRect(x: startX - 1, y: height - height / 6 - 1, width: 2, height: 2))

                CGContextMoveToPoint(ctx, endX, height / 6 * 3)
                CGContextAddLineToPoint(ctx, endX, height - height / 6 - 1)
                CGContextStrokePath(ctx)

                CGContextStrokeEllipseInRect(ctx, CGRect(x: endX - 1, y: height - height / 6 - 1, width: 2, height: 2))


                let textAttributes = [
                        NSForegroundColorAttributeName: overlapColor,
                        NSFontAttributeName: UIFont.monospacedDigitSystemFontOfSize(8, weight: 0)// systemFontOfSize(8)
                ]

                let startTextSize = startText.sizeWithAttributes(textAttributes)
                startText.drawAtPoint(CGPoint(x: startX - startTextSize.width / 2, y: height - height / 6), withAttributes: textAttributes)

                let endTextSize = endText.sizeWithAttributes(textAttributes)
                endText.drawAtPoint(CGPoint(x: endX - endTextSize.width / 2, y: height - height / 6), withAttributes: textAttributes)
            }

            // Draw overlap indicator

            for interval in overlap.overlapIntervalsInTimeZone(targetTimeZone) {
                let startX = CGFloat(interval.start - start) * width / count + startOffest
                let endX = CGFloat(interval.end - start) * width / count + startOffest
                drawOverlap(startX, endX: endX, startText: "\(interval.start)", endText: "\(interval.end)")
            }

            // Draw indicator #1

            for interval in overlap.interval1.adjustedIntervalsInTimeZone(targetTimeZone) {
                let startX = CGFloat(interval.start - start) * width / count + startOffest
                let startY = height / 6 * 3
                let endX = CGFloat(interval.end - start) * width / count + startOffest
                let endY = height / 6 * 3
                drawIndicatorWithColor(sourceColor, startX: startX, startY: startY, endX: endX, endY: endY)
            }

            // Draw indicator #2

            for interval in overlap.interval2.adjustedIntervalsInTimeZone(targetTimeZone) {
                let startX = CGFloat(interval.start - start) * width / count + startOffest
                let startY = height / 6 * 4
                let endX = CGFloat(interval.end - start) * width / count + startOffest
                let endY = height / 6 * 4
                drawIndicatorWithColor(destinationColor, startX: startX, startY: startY, endX: endX, endY: endY)
            }


        }
    }
}
