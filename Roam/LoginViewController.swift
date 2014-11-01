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
        let permissionsArray:NSArray = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
        PFFacebookUtils.logInWithPermissions(permissionsArray, block: { user, error in
            if (user == nil) {
                var errorMessage:String? = nil
                if (error == nil) {
                    errorMessage = "Uh oh. The user cancelled the Facebook login"
                } else {
                    errorMessage = error.localizedDescription
                }
                let alert: UIAlertController = UIAlertController(title: "Log In Error", message: errorMessage, preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(defaultAction)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                if (user.isNew) {
                    println("User with facebook signe dup and logged in!")
                } else {
                    println("User with facebook logged in!")
                }
                self.presentUserDetailsViewControllerAnimated(true)
            }
        })
    }
    
    func presentUserDetailsViewControllerAnimated(animated:Bool) {
        
    }


}