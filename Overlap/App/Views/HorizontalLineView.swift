//
// Created by Maxim Pervushin on 02/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class HorizontalLineView: UIView {

    private var thickness: CGFloat {
        return 1.0 / UIScreen.mainScreen().scale
    }

    private var _frame: CGRect

    override var frame: CGRect {
        set {
            setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
            setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
            _frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: newValue.size.width, height: thickness)
            super.frame = _frame
        }
        get {
            return _frame
        }
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(size.width, thickness)
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(UIViewNoIntrinsicMetric, thickness)
    }

    override init(frame: CGRect) {
        _frame = CGRectZero
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        _frame = CGRectZero
        super.init(coder: aDecoder)
    }
}
