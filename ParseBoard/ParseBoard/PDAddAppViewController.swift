//
//  LoginViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDAddAppViewController: UIViewController {
    
    @IBOutlet var appIDTextField: UITextField!
    @IBOutlet var clientKeyTextField: UITextField!
    @IBOutlet var appNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButtonClick(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        var appInfo: AppInfo = AppInfo.MR_createEntity() as AppInfo
        appInfo.appid = appIDTextField.text
        appInfo.clientkey = clientKeyTextField.text
        appInfo.appname = appNameTextField.text
        
        var classes: PFClass = PFClass.MR_createEntity() as PFClass
        classes.classname = "_User"
        classes.app = appInfo
        
        appInfo.addClassesObject(classes)
        
        PDUtitility.saveContext()
        
        PDUtitility.setCurrentAppWithAppID(appInfo.appid)
        
        var appDelegate = UIApplication.sharedApplication().delegate as PDAppDelegate
        appDelegate.setMainView()
    }
}
