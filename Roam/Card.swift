//
//  Card.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

import UIKit

class Card: UIView {
    let DESCRIPTION_WIDTH_RATIO:CGFloat = 0.92
    let DESCRIPTION_HEIGHT_RATIO:CGFloat = 0.28
    let PHOTODESCRIPTION_SPACING_RATIO:CGFloat = 0.0001
    let DESCRIPTIONDIVIDER_SPACING_RATIO:CGFloat = 0.0001
    
    let CP_RATIO:CGFloat = 0.38
    let PP_RATIO:CGFloat = 0.247
    let PP_X_RATIO:CGFloat = 0.0552
    let PP_Y_RATIO:CGFloat = 0.246
    let PP_BUFF:CGFloat = 3

    let TEXT_WIDTH_RATIO = 0.9
    let TEXT_HEIGHT_RATIO = 0.8
    
    var panGestureRecognizer:UIPanGestureRecognizer?
    var profileImageView: UIImageView?
    var itinImageView: UIImageView?
    var nameLabel: UILabel?
    var bookButton: UIButton?
    var descriptionLabel: UILabel?
    
    
    override init() {
       super.init()
        self.cardSetup()
    }
    
    func setupPhotos() {
        var height = CGFloat(self.frame.size.height)
        var width = CGFloat(self.frame.size.width)
        
        var cp_mask = UIView(frame: CGRectMake(0, 0, width, height * CP_RATIO))
        var pp_mask = UIView(frame: CGRectMake(width * PP_X_RATIO, height * PP_Y_RATIO, height * PP_RATIO, height * PP_RATIO))
        var pp_circle = UIView(frame: CGRectMake(pp_mask.frame.origin.x - PP_BUFF, pp_mask.frame.origin.y - PP_BUFF, pp_mask.frame.size.width + 2 * PP_BUFF, pp_mask.frame.size.width + 2 * PP_BUFF))
        pp_circle.backgroundColor = UIColor.whiteColor()
        pp_circle.layer.cornerRadius = pp_circle.frame.size.height/2
        pp_mask.layer.cornerRadius = pp_mask.frame.size.height/2
        profileImageView = UIImageView(frame: CGRectMake(0, 0, pp_mask.frame.size.width, pp_mask.frame.size.height))
        itinImageView = UIImageView(frame: cp_mask.frame)
        itinImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        cp_mask.addSubview(itinImageView!)
        pp_mask.addSubview(profileImageView!)
        cp_mask.clipsToBounds = true
        pp_mask.clipsToBounds = true
        
        itinImageView?.backgroundColor = UIColor.lightGrayColor()
        
        nameLabel = UILabel(frame: CGRectMake((pp_circle.frame.origin.x + pp_circle.frame.size.width), (cp_mask.frame.size.height + 7.0), self.frame.size.width, 26))
        nameLabel?.font = UIFont(name: "HelveticaNeue", size: CGFloat(20))
        nameLabel?.textColor = UIColor(red: 0.33, green: 0.49, blue: 0.6, alpha: 1)
        var descriptionHeight:CGFloat = self.frame.size.height * DESCRIPTION_HEIGHT_RATIO / 2;
        var descriptionWidth:CGFloat = self.frame.size.width * DESCRIPTION_WIDTH_RATIO;

        nameLabel?.text = "TESTING"
        
        self.addSubview(nameLabel!)
        self.addSubview(cp_mask)
        self.addSubview(pp_circle)
        self.addSubview(pp_mask)
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
        self.setupPhotos()
        self.layer.cornerRadius = 8
    }

}
