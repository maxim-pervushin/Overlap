//
// Created by Maxim Pervushin on 02/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import Foundation

extension Double {

    func timeString() -> String {
        let hours = Int(self)
        let minutes = self - Double(hours) * 60
        return String(format: "%d:%02d", hours, minutes)
    }
}