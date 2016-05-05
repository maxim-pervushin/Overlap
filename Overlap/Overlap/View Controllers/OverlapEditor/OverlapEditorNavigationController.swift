//
// Created by Maxim Pervushin on 05/05/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class OverlapEditorNavigationController: UINavigationController {

    // MARK: public

    var overlap: Overlap? {
        set {
            _overlapEditorViewController?.overlap = newValue
        }
        get {
            return _overlapEditorViewController?.overlap
        }
    }

    var finished: (Overlap? -> Void)? {
        set {
            _overlapEditorViewController?.finished = newValue
        }
        get {
            return _overlapEditorViewController?.finished
        }
    }

    // MARK: private

    private var _overlapEditorViewController: OverlapEditorViewController? {
        for viewController in viewControllers {
            if let overlapEditorViewController = viewController as? OverlapEditorViewController {
                return overlapEditorViewController
            }
        }
        return nil
    }
}
