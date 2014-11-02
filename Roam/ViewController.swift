//
//  ViewController.swift
//  Roam
//
//  Created by Richard Kim on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

import UIKit
import Parse



class ViewController: UIViewController {
    
    var myScrollView : CardScrollView?
    var itinArray: NSMutableArray?
    var itinCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        myScrollView = CardScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.setupClipView()
        self.view.addSubview(myScrollView!)
        super.viewDidLoad()
        
        var test:PFGeoPoint = PFGeoPoint(location: CLLocation(latitude: 0, longitude: 0)!)
        self.fetchItineraries(test, rangeStart: NSDate(timeIntervalSince1970: 0), rangeEnd: NSDate(timeIntervalSinceNow: 1000))
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupClipView() {
        var clipView = ClipView(frame: self.view.frame)
        clipView.scrollView = myScrollView
        self.view.addSubview(clipView)
    }

    func fetchItineraries(location:PFGeoPoint, rangeStart:NSDate, rangeEnd:NSDate) {
        itinArray = NSMutableArray()
        itinCount = 0
        
        PFCloud.callFunctionInBackground("getItineraries", withParameters: ["location" : location, "rangeStart":rangeStart,"rangeEnd":rangeEnd], block: { (results:AnyObject!, error:NSError!) -> Void in
            if (error != nil) {
                println("Error getting Itineraries")
            } else {
                for itin in results as [AnyObject] {
                    self.itinArray?.addObject(itin)
                }
                self.myScrollView?.addCardsForItins(self.itinArray!)
            }
        })
    }

}

