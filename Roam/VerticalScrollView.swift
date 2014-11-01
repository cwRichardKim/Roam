//
//  VerticalScrollView.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//import Cocoa
import UIKit

class VerticalScrollView: UIScrollView, UIScrollViewDelegate {
    
    var card:Card?
    var containerDelegate:CardScrollView?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.viewSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }


    
    func viewSetup() {
        self.delegate = self
        self.clipsToBounds = false
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.setContentOffset(CGPoint(x: 0, y: self.frame.size.height), animated: false)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*3)
        card?.center = CGPointMake(self.contentSize.width/2,self.contentSize.height/2)
        self.addSubview(card!)
    }
   

    
}
