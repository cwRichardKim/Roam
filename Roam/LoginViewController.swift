//
//  LoginViewController.swift
//  Roam
//
//  Created by Jared Moskowitz on 11/1/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

//import Cocoa
import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
        self.layoutSubviews()
    }
    
    func layoutSubviews() {
        var frame = facebookLoginButton.frame
        frame.size.width = self.view.frame.size.width
        frame.size.height = self.view.frame.size.height*CGFloat(0.1)
        frame.origin.x = self.view.frame.origin.x
        frame.origin.y = self.view.frame.height - frame.size.height
        facebookLoginButton.frame = frame
        facebookLoginButton.backgroundColor = UIColor(red: 0.25, green: 0.37, blue: 0.61, alpha: 1)
        
    }
    @IBAction func facebookLoginButtonPressed(sender: AnyObject) {
        
        
    }


}