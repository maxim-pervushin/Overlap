//
// Created by Maxim Pervushin on 08/04/16.
// Copyright (c) 2016 Maxim Pervushin. All rights reserved.
//

import UIKit

class EditOverlapViewController: UIViewController {
    
    // MARK: @IB
    
    @IBOutlet weak var overlapView: OverlapView?
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: public
    
    var overlap: Overlap? {
        didSet {
            overlapView?.overlap = overlap
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlap = Overlap(NSTimeZone(abbreviation: "MSK")!, 16, 9, NSTimeZone(abbreviation: "MSK")!, 8, 17)
    }
}
