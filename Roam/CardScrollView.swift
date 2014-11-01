//
//  CardScrollView.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//import Cocoa
import UIKit


class CardScrollView: UIScrollView {
    
    
    let Y_TOP_BUFFER:CGFloat = 30.0
    let Y_BOT_BUFFER:CGFloat = 80.0
    let X_BUFFER:CGFloat = 15.0
    let CARD_X_BUFFER:CGFloat = 5.0
    
    var cardsArray = [VerticalScrollView]()
    
    override init() {
        super.init()
        self.viewSetup()
    }
    
    init(cards:[VerticalScrollView]) {
        super.init()
        cardsArray = cards
        self.viewSetup()
    }
    
    override init(frame: CGRect) {
        var newFrame = frame
        newFrame.origin.x += X_BUFFER
        newFrame.size.width -= X_BUFFER*2
        super.init(frame: newFrame)
        self.viewSetup()
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
    func viewSetup() {
        self.clipsToBounds = false
    }
    
    override func layoutSubviews() {
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    func addCards(cards: [Card]) {
        for card in cards {
            self.addCard(card as Card)
        }
    }
    
    func addCard(card: Card) {
        var w:CGFloat = CGFloat(cardsArray.count)
        var temp = w*self.frame.size.width
        let frame = CGRectMake(CGFloat(temp), 0.0, self.frame.size.width,self.frame.size.height)
        var vScrollView = VerticalScrollView(frame: frame)
        var test:CGFloat = vScrollView.frame.size.width - 2*CARD_X_BUFFER
        var rect:CGRect = CGRectMake(CGFloat(CARD_X_BUFFER),CGFloat(Y_TOP_BUFFER),CGFloat(vScrollView.frame.size.width - 2*CARD_X_BUFFER),CGFloat(vScrollView.frame.size.height - Y_TOP_BUFFER - Y_BOT_BUFFER))
        card.frame = rect
        vScrollView.card = card
        cardsArray.append(vScrollView)
        self.addSubview(vScrollView)
        self.expandScrollView()
    }
    
    func expandScrollView() {
        var size = self.contentSize
        size.width = self.frame.size.width
        self.contentSize = size
    }
    
}
