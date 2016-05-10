import UIKit

@IBDesignable class OverlapView: UIView {

    @IBInspectable var sourceColor = UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.00)
    @IBInspectable var destinationColor = UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.00)
//    @IBInspectable var overlapColor = UIColor(red:0.50, green:0.55, blue:0.55, alpha:1.00)
    @IBInspectable var overlapColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.00)
    @IBInspectable var rulerColor = UIColor(red:0.74, green:0.76, blue:0.78, alpha:1.00)
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    var overlap: Overlap? {
        didSet {
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

        let startOffest = CGFloat(12)
        let endOffest = CGFloat(12)

        let width = bounds.width - startOffest - endOffest

        let start = Double(0)
        let end = Double(24 * 60)
        let count = CGFloat(end - start) / 60

        func drawRuler() {
            CGContextSetLineWidth(ctx, 1 / UIScreen.mainScreen().scale)
            CGContextSetStrokeColorWithColor(ctx, rulerColor.CGColor)

            let textAttributes = [
                    NSForegroundColorAttributeName: rulerColor,
                    NSFontAttributeName: UIFont.systemFontOfSize(8)
//                NSFontAttributeName: UIFont.monospacedDigitSystemFontOfSize(8, weight: 0)// systemFontOfSize(8)
            ]

            let hourSize = width / 24
            for i in 0...24 {
                let x = CGFloat(i) * hourSize + startOffest
                CGContextMoveToPoint(ctx, x, height / 6 * 1.5)
                CGContextAddLineToPoint(ctx, x, height / 6 * 1.75)
                if 0 == i % 6 {
                    let text = NSString(string: "\(Int(i))")
                    let size = text.sizeWithAttributes(textAttributes)
                    text.drawAtPoint(CGPoint(x: x - size.width / 2, y: 0), withAttributes: textAttributes)
                }
            }
            
            CGContextStrokePath(ctx)
        }

        drawRuler()

        if let overlap = overlap {

            let targetTimeZone = overlap.interval2.timeZone

            func drawIndicatorWithColor(color: UIColor, startX: CGFloat, startY: CGFloat, endX: CGFloat, endY: CGFloat) {

                CGContextSetLineWidth(ctx, 2 / UIScreen.mainScreen().scale)
                CGContextSetStrokeColorWithColor(ctx, color.CGColor)

//                CGContextMoveToPoint(ctx, startX + 1, startY)
//                CGContextAddLineToPoint(ctx, endX - 1, endY)
                CGContextMoveToPoint(ctx, startX, startY)
                CGContextAddLineToPoint(ctx, endX, endY)
                CGContextStrokePath(ctx)

//                CGContextStrokeEllipseInRect(ctx, CGRect(x: startX - 1, y: startY - 1, width: 2, height: 2))
//                CGContextStrokeEllipseInRect(ctx, CGRect(x: endX - 1, y: endY - 1, width: 2, height: 2))
            }

            func drawOverlap(startX: CGFloat, endX: CGFloat, startText: String, endText: String) {
                CGContextSetLineWidth(ctx, 2 / UIScreen.mainScreen().scale)
                CGContextSetFillColorWithColor(ctx, overlapColor.colorWithAlphaComponent(0.15).CGColor)
                CGContextSetStrokeColorWithColor(ctx, overlapColor.CGColor)
                CGContextFillRect(ctx, CGRect(x: startX, y: height / 6 * 3, width: endX - startX, height: height / 6 * 2))

                CGContextMoveToPoint(ctx, startX, height - height / 6)
                CGContextAddLineToPoint(ctx, endX, height - height / 6)
                CGContextStrokePath(ctx)

//                CGContextMoveToPoint(ctx, startX, height / 6 * 3)
//                CGContextAddLineToPoint(ctx, startX, height - height / 6 - 1)
//                CGContextStrokePath(ctx)

//                CGContextStrokeEllipseInRect(ctx, CGRect(x: startX - 1, y: height - height / 6 - 1, width: 2, height: 2))

//                CGContextMoveToPoint(ctx, endX, height / 6 * 3)
//                CGContextAddLineToPoint(ctx, endX, height - height / 6 - 1)
//                CGContextStrokePath(ctx)

//                CGContextStrokeEllipseInRect(ctx, CGRect(x: endX - 1, y: height - height / 6 - 1, width: 2, height: 2))


                let textAttributes = [
                        NSForegroundColorAttributeName: overlapColor,
                        NSFontAttributeName: UIFont.systemFontOfSize(8)
//                        NSFontAttributeName: UIFont.monospacedDigitSystemFontOfSize(8, weight: 0)// systemFontOfSize(8)
                ]

                let startTextSize = startText.sizeWithAttributes(textAttributes)
                startText.drawAtPoint(CGPoint(x: startX - startTextSize.width / 2, y: height - height / 6 + 2), withAttributes: textAttributes)

                let endTextSize = endText.sizeWithAttributes(textAttributes)
                endText.drawAtPoint(CGPoint(x: endX - endTextSize.width / 2, y: height - height / 6 + 2), withAttributes: textAttributes)
            }

            // Draw overlap indicator

            for interval in overlap.overlapIntervalsInTimeZone(targetTimeZone) {
                let startX = CGFloat(interval.start - start) * width / count + startOffest
                let endX = CGFloat(interval.end - start) * width / count + startOffest
                drawOverlap(startX, endX: endX, startText: "\(interval.start.timeString())", endText: "\(interval.end.timeString())")
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
