//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

@IBDesignable class RoundedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
