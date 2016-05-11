//
// Created by Maxim Pervushin on 11/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

@IBDesignable class Label: UILabel {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }

    // MARK: private
    
    private func _commonInit() {
        clipsToBounds = true
        cornerRadius = 2
    }
}
