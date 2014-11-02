//
//  Card.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

import UIKit

class Card: UIView, UIGestureRecognizerDelegate {
    let DESCRIPTION_WIDTH_RATIO:CGFloat = 0.9
    let DESCRIPTION_HEIGHT_RATIO:CGFloat = 0.28
    let DESCRIPTION_Y_RATIO:CGFloat = 0.55
    let MORE_BUTTON_Y_RATIO:CGFloat = 0.68
    let PHOTODESCRIPTION_SPACING_RATIO:CGFloat = 0.0001
    let DESCRIPTIONDIVIDER_SPACING_RATIO:CGFloat = 0.78
    let DIVIDER_RATIO:CGFloat = 27.0
    let DIVIDER_ALPHA:CGFloat = 0.3
    
    let SCHOOL_LABEL_BUFFER:CGFloat = 3.0
    let SCHOOL_LABEL_HEIGHT:CGFloat = 16.0
    
    let BOOK_BUTTON_WIDTH_RATIO:CGFloat = 0.9
    let BOOK_BUTTON_HEIGHT:CGFloat = 45.0
    
    let RATINGS_WIDTH_RATIO:CGFloat = 0.9 //from the pp circle
    let RATINGS_HEIGHT_RATIO:CGFloat = 0.13 //from the pp circle
    
    let CP_RATIO:CGFloat = 0.38
    let PP_RATIO:CGFloat = 0.247
    let PP_X_RATIO:CGFloat = 0.025
    let PP_Y_RATIO:CGFloat = 0.21
    let PP_BUFF:CGFloat = 3

    let TEXT_WIDTH_RATIO:CGFloat = 0.9
    let TEXT_HEIGHT_RATIO:CGFloat = 0.8
    
    var panGestureRecognizer:UIPanGestureRecognizer?
    var profileImageView:PFImageView = PFImageView()
    var itinImageView: PFImageView = PFImageView()
    var nameLabel: UILabel = UILabel()
    var schoolLabel: UILabel?
    var bookButton: UIButton?
    var descriptionLabel: UILabel = UILabel()
    var dividerView1:UIView?
    var dividerView2:UIView?
    var ratingsImageView:UIImageView = UIImageView()
    var numRatingsLabel:UILabel = UILabel()
    var phoneNumber:NSString = "-1"
    var fullDescription:NSString = ""
    var price:CGFloat =  0.0
    
//    var bookButton:UIButton?
   var ven = PaymentController()
    
    override init() {
       super.init()
        self.cardSetup()
    }
    
    func setupCardVisuals() {
        self.clipsToBounds = true
        var height = CGFloat(self.frame.size.height)
        var width = CGFloat(self.frame.size.width)
        
        var cp_mask = UIView(frame: CGRectMake(0, 0, width, height * CP_RATIO))
        var pp_mask = UIView(frame: CGRectMake(width * PP_X_RATIO, height * PP_Y_RATIO, height * PP_RATIO, height * PP_RATIO))
        var pp_circle = UIView(frame: CGRectMake(pp_mask.frame.origin.x - PP_BUFF, pp_mask.frame.origin.y - PP_BUFF, pp_mask.frame.size.width + 2 * PP_BUFF, pp_mask.frame.size.width + 2 * PP_BUFF))
        pp_circle.backgroundColor = UIColor.whiteColor()
        pp_circle.layer.cornerRadius = pp_circle.frame.size.height/2
        pp_mask.layer.cornerRadius = pp_mask.frame.size.height/2
        profileImageView.frame = CGRectMake(0, 0, pp_mask.frame.size.width, pp_mask.frame.size.height)
        itinImageView.frame = cp_mask.frame
        itinImageView.contentMode = UIViewContentMode.ScaleAspectFill
        cp_mask.addSubview(itinImageView)
        pp_mask.addSubview(profileImageView)
        cp_mask.clipsToBounds = true
        pp_mask.clipsToBounds = true
        
        itinImageView.backgroundColor = UIColor.lightGrayColor()
        
        nameLabel.frame = CGRectMake((pp_circle.frame.origin.x + pp_circle.frame.size.width), (cp_mask.frame.size.height + 7.0), self.frame.size.width, 26)
        nameLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(20))
        nameLabel.textColor = UIColor(red: 0.33, green: 0.49, blue: 0.6, alpha: 1)
        
        var dividerHeight = DIVIDER_RATIO
        var dividerWidth = CGFloat(1.0)
        var dividerY:CGFloat = self.frame.size.height*DESCRIPTIONDIVIDER_SPACING_RATIO
        var dividerX1:CGFloat = self.frame.size.width/3
        var dividerX2:CGFloat = self.frame.size.width*(2/3)
        var dividerView1 = UIView(frame: CGRect(x: dividerX1, y: dividerY, width: dividerWidth, height: dividerHeight))
        var dividerView2 = UIView(frame: CGRect(x: dividerX2, y: dividerY, width: dividerWidth, height: dividerHeight))
        dividerView1.backgroundColor = UIColor.grayColor()
        dividerView2.backgroundColor = UIColor.grayColor()
        dividerView1.alpha = DIVIDER_ALPHA
        dividerView2.alpha = DIVIDER_ALPHA
        
        self.addSubview(dividerView1)
        self.addSubview(dividerView2)
        self.addSubview(descriptionLabel)
        self.addSubview(nameLabel)
        self.addSubview(cp_mask)
        self.addSubview(pp_circle)
        self.addSubview(pp_mask)
        
        self.setupMoreButton()
        self.setupBookButton()
        
        self.setupschoolLabel(CGRectMake((pp_circle.frame.origin.x + pp_circle.frame.size.width), (cp_mask.frame.size.height + 7.0), self.frame.size.width, 26))
        self.setupRatings(pp_circle.frame)
    }
    
    
    // MARK: buttons
    
    func setupMoreButton() {
        let yval:CGFloat = self.frame.height * MORE_BUTTON_Y_RATIO
        let moreButton = UIButton(frame: CGRect(x: self.frame.size.width/5, y: yval, width: self.frame.size.width/5*3, height: 30))
        moreButton.setTitle("Read More", forState: UIControlState.Normal)
        moreButton.setTitleColor(UIColor(red: 0.46, green: 0.67, blue: 0.93, alpha: 1), forState: UIControlState.Normal)
        moreButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        self.addSubview(moreButton)
        moreButton.addTarget(self, action: "moreButtonTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func moreButtonTouchUpInside() {
        
    }
    
    func setupBookButton() {
        let buffer = CGFloat((1.0 - BOOK_BUTTON_WIDTH_RATIO) / 2.0) * self.frame.width
        
        bookButton = UIButton(frame: CGRectMake(buffer, self.frame.height - buffer - BOOK_BUTTON_HEIGHT, self.frame.width * BOOK_BUTTON_WIDTH_RATIO, BOOK_BUTTON_HEIGHT))
        bookButton?.backgroundColor = UIColor(red: 0.15, green: 0.67, blue: 0.88, alpha: 1)
        bookButton?.layer.cornerRadius = BOOK_BUTTON_HEIGHT * 0.1
        self.addSubview(bookButton!)
        bookButton?.addTarget(self, action: "bookButtonTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        bookButton?.setTitle("Book", forState: UIControlState.Normal)
        bookButton?.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
    }
    
    func bookButtonTouchUpInside() {
        //REPLACE WITH INPUT HERE
        ven.pay(self.phoneNumber, with:self.price)
    }
    
    // MARK: text
    
    func setupschoolLabel(nameFrame:CGRect) {
        schoolLabel = UILabel(frame: CGRectMake(nameFrame.origin.x, nameFrame.origin.y + nameFrame.height + SCHOOL_LABEL_BUFFER, nameFrame.width, SCHOOL_LABEL_HEIGHT))
        schoolLabel?.text = "Tufts University '17"
        schoolLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.addSubview(schoolLabel!)
    }
    
    func setDescriptionText(string1:NSString, string2:NSString) {
        var descriptionHeight:CGFloat = self.frame.size.height * DESCRIPTION_HEIGHT_RATIO / 2;
        var descriptionWidth:CGFloat = self.frame.size.width * DESCRIPTION_WIDTH_RATIO;

        var descriptionX:CGFloat = (self.frame.size.width - descriptionWidth) / 2
        var descriptionY:CGFloat = self.frame.size.height * DESCRIPTION_Y_RATIO
        descriptionLabel.frame = CGRect(x:descriptionX, y: descriptionY, width: descriptionWidth, height: descriptionHeight)
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        descriptionLabel.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1)
        nameLabel.textColor = UIColor(red: 0.33, green: 0.49, blue: 0.6, alpha: 1)
        descriptionLabel.numberOfLines = 3
        
        let str1 = "Let me show you "
        let str2 = NSAttributedString(string: " and ")
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 15)
        
        let boldedString1 = NSMutableAttributedString(string: string1)
        boldedString1.addAttribute(NSFontAttributeName, value: boldFont!, range: NSMakeRange(0, boldedString1.length))
        let boldedString2 = NSMutableAttributedString(string: string2)
        boldedString2.addAttribute(NSFontAttributeName, value: boldFont!, range: NSMakeRange(0, boldedString2.length))

        var descriptionString = NSMutableAttributedString(string: str1)
        descriptionString.appendAttributedString(boldedString1)
        descriptionString.appendAttributedString(str2)
        descriptionString.appendAttributedString(boldedString2)
        descriptionLabel.attributedText = descriptionString
        descriptionLabel.textAlignment = NSTextAlignment.Center
    }
    
    // MARK: ratings
    
    func setupRatings(circleFrame:CGRect) {
        let buffer:CGFloat = (1.0 - RATINGS_WIDTH_RATIO) / 2.0 * circleFrame.width
        let height:CGFloat = RATINGS_HEIGHT_RATIO * circleFrame.height
        var frame:CGRect = CGRectMake(buffer + circleFrame.origin.x, circleFrame.height + circleFrame.origin.y, circleFrame.width * RATINGS_WIDTH_RATIO, height)
        ratingsImageView.frame = frame
        ratingsImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(ratingsImageView)
        
        frame.origin.y += 20
        numRatingsLabel.frame = frame
        numRatingsLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        numRatingsLabel.textAlignment = NSTextAlignment.Center
        numRatingsLabel.textColor = UIColor(red: 0.64, green: 0.64, blue: 0.64, alpha: 0.7)
        
        self.addSubview(numRatingsLabel)
    }
    
    func setRatingStars(rating:Float, numReviewers:Int) {
        var stars = lroundf(rating * 2.0)
        if (stars < 0) {stars = 0}
        if (stars > 10) {stars = 10}
        var temp:Float = Float(stars) / 2.0
        var str = String(format: "%.1f", temp)
        var string = NSString(string: str)
        string = string.stringByAppendingString(" stars")
        ratingsImageView.image = UIImage(named: string)
        numRatingsLabel.text = NSString()
        numRatingsLabel.text = NSString(format: "%i Reviews", numReviewers)
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
        self.setupCardVisuals()
    }

    

}
