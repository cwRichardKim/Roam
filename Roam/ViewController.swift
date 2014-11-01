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

    override func viewDidLoad() {
        super.viewDidLoad()
        var testObject = PFObject(className: "TestObject")
        testObject.setObject("TEST", forKey: "testKey")
        testObject.saveInBackgroundWithBlock(nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

