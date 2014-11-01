//
//  Card.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

import UIKit

class Card: UIView {
    
    var panGestureRecognizer:UIPanGestureRecognizer?
    var profileCircleView: UIView?
    var profileImageView: UIImageView?
    var itinImageView: UIImageView?
    var nameLabel: UILabel?
    var bookButton: UIButton?
    var descriptionLabel: UILabel?
    
    
    override init() {
       super.init()
        self.cardSetup()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func cardSetup() {
        
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 8
    }

}
