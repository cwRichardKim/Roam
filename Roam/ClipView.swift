//
//  ClipView.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//import Cocoa
import UIKit

class ClipView: UIView {
    
    var scrollView:CardScrollView?
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return self.pointInside(point, withEvent:event) ? scrollView : nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

}
