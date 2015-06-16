//
//  LoginViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDLoginViewController: UIViewController {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        PDUtitility.trackWithScreenName("Add App")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getKeysClicked(sender: AnyObject) {
        var webVC: PDWebViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PDWebViewController") as! PDWebViewController
        webVC.url = "https://www.parse.com/apps"
        
        var nav: UINavigationController = UINavigationController(rootViewController: webVC)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButtonClick(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/apps")!)
        request.addValue(usernameTF.text, forHTTPHeaderField: "X-Parse-Email")
        request.addValue(passwordTF.text, forHTTPHeaderField: "X-Parse-Password")
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (r, d, e) -> Void in
            var result: NSDictionary = NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
            println(result)
            var appDelegate = UIApplication.sharedApplication().delegate as! PDAppDelegate
            var results: [AnyObject] = result["results"] as! [AnyObject]
            appDelegate.setMainViewWithApps(results)
        }
        
    }
}
