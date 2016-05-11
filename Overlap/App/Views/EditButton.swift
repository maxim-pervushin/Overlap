//
// Created by Maxim Pervushin on 02/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

@IBDesignable class EditButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    func setColor(color: UIColor) {
        backgroundColor = color.colorWithAlphaComponent(0.3)
        setTitleColor(color)
        tintColor = color
        _editImageView.tintColor = color
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let offset = CGFloat(4)
        let imageSize = CGSize(width: frame.size.height - 2 * offset, height: frame.size.height - 2 * offset)
        let imageOrigin = CGPoint(x: frame.size.width - imageSize.width - offset, y: offset)
        _editImageView.frame = CGRect(origin: imageOrigin, size: imageSize)
    }

    private func _commonInit() {
        setColor(UIColor.greenColor())
        tintColor = UIColor.greenColor()
        _editImageView.tintColor = UIColor.greenColor()
        cornerRadius = 2
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        addSubview(_editImageView)
    }

    private let _editImageView = UIImageView(image: UIImage(named: "Edit")?.imageWithRenderingMode(.AlwaysTemplate))
}

extension UIButton {

    func setTitle(title: String) {
        setTitle(title, forState: .Normal)
        setTitle(title, forState: .Selected)
        setTitle(title, forState: .Disabled)
        setTitle(title, forState: .Highlighted)
        if #available(iOS 9.0, *) {
            setTitle(title, forState: .Focused)
        }
    }

    func setTitleColor(color: UIColor) {
        setTitleColor(color, forState: .Normal)
        setTitleColor(color, forState: .Selected)
        setTitleColor(color, forState: .Disabled)
        setTitleColor(color, forState: .Highlighted)
        if #available(iOS 9.0, *) {
            setTitleColor(color, forState: .Focused)
        }
    }
}
