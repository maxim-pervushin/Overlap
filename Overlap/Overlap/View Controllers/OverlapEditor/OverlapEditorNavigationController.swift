//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapEditorNavigationController: UINavigationController {

    var overlap: Overlap? {
        set {
            overlapEditorViewController?.overlap = newValue
        }
        get {
            return overlapEditorViewController?.overlap
        }
    }

    private var overlapEditorViewController: OverlapEditorViewController? {
        for viewController in viewControllers {
            if let overlapEditorViewController = viewController as? OverlapEditorViewController {
                return overlapEditorViewController
            }
        }
        return nil
    }
}
