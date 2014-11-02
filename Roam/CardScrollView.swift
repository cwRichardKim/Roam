//
//  CardScrollView.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//import Cocoa
import UIKit
import AlamoFire

class CardScrollView: UIScrollView, UIScrollViewDelegate {
    
    
    
    let Y_TOP_BUFFER:CGFloat = 30.0
    let Y_BOT_BUFFER:CGFloat = 80.0
    let X_BUFFER:CGFloat = 15.0
    let CARD_X_BUFFER:CGFloat = 5.0
    
    var lastContentOffsetY:CGFloat?
    var lastContentOffsetX:CGFloat?
    var lastContentOffSetHorizontal:CGFloat?
    var lastHorizontalLeftSwipe = false
    var lastPoint:CGPoint?
    
    var startingPoint:CGPoint?
    
    var cardsArray = [VerticalScrollView]()
    
    override init() {
        super.init()
        self.delegate = self
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
        self.delegate = self
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
        startingPoint = self.frame.origin
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
        vScrollView.containerDelegate = self
        vScrollView.delegate = self
        var rect:CGRect = CGRectMake(CGFloat(CARD_X_BUFFER),CGFloat(Y_TOP_BUFFER),CGFloat(vScrollView.frame.size.width - 2*CARD_X_BUFFER),CGFloat(vScrollView.frame.size.height - Y_TOP_BUFFER - Y_BOT_BUFFER))
        card.frame = rect
        vScrollView.card = card
        cardsArray.append(vScrollView)
        self.addSubview(vScrollView)
        self.expandScrollView()
    }
    
    
    func removeVerticalViewAndCard(verticalScroll: VerticalScrollView) {
        let card = verticalScroll.card
        var index:Int = self.indexOfFirstCardToShift(verticalScroll)
        cardsArray.removeAtIndex(index)
        verticalScroll.removeFromSuperview()
        self.contractScrollView()
        self.fillEmptyCardSpaceWithIndex(index)
//        if let index = find(self.notes, note) {
//            
//        }
//        let index = find(cardsArray, card)
//        cardsArray.removeAtIndex(index!)
    }
    
    func indexOfFirstCardToShift(vs:VerticalScrollView) -> Int {
        var i = 0
        for view in cardsArray {
            if (vs == cardsArray[i]) {
                return i;
            }
            i++
        }
        return i
    }
    
    func expandScrollView() {
        var size = self.contentSize
        size.width += self.frame.size.width
        self.contentSize = size
    }
    
    
    func contractScrollView() {
        var size = self.contentSize
        size.width -= self.frame.size.width
        self.contentSize = size
        
    }
    
    func fillEmptyCardSpaceWithIndex(index:Int) {
        for var i = index; i < countElements(cardsArray); ++i {
            UIView.animateWithDuration(0.5, animations: {
                var frame:CGRect = self.cardsArray[i].frame
                frame.origin.x -= self.cardsArray[i].frame.size.width
                self.cardsArray[i].frame = frame
            })
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(lastPoint == nil) {
            lastPoint = scrollView.frame.origin
        }
        //scrolling left and right
        if(scrollView == self) {
            lastHorizontalLeftSwipe = self.contentOffset.x > 0.0
            lastContentOffSetHorizontal = self.contentOffset.x
            lastPoint = self.frame.origin
        } else { //scrolling up and down
            var scrollDirectionVerticalUp = lastContentOffsetY < self.contentOffset.y
            var scrollDirectionVerticalDown = lastContentOffsetY > self.contentOffset.y
        }
    }
    
    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(scrollView != self) {
            var y = targetContentOffset.memory.y
            if (y > (self.frame.origin.y + self.frame.size.height)) {
                self.removeVerticalViewAndCard(scrollView as VerticalScrollView)
            }
        } else {
            
        }
    }
    
    
    func didCompleteUpAction()->Bool{
        return true
    }
    
    func didCompleteDownAction()->Bool{
        return false
    }
    
    
}
