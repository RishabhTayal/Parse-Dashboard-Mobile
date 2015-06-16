//
//  AppDelegate.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class PDAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics()])
        
        MagicalRecord.setupCoreDataStackWithStoreNamed("Model")
        
        GAI.sharedInstance().trackUncaughtExceptions = false
        
        GAI.sharedInstance().dispatchInterval = 20
        
        GAI.sharedInstance().trackerWithTrackingId("UA-40631521-13")
        
        if (AppInfo.MR_numberOfEntities() != 0) {
            setMainView()
        } else {
            setAddAppView()
        }
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 81/255, green: 153/255, blue: 250/255, alpha: 1.0)
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict as [NSObject : AnyObject]
        
        return true
    }
    
    func setMainView() {
        
        PDUtitility.setCurrentAppWithAppID(PDUtitility.getCurrentApp().appid)
        
        var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: PDFirstViewController = sb.instantiateViewControllerWithIdentifier("PDFirstViewController") as! PDFirstViewController
        var vcNav: UINavigationController = UINavigationController(rootViewController: vc)
        
        var menu:PDMenuViewController = PDMenuViewController()
        var inst: MFSideMenuContainerViewController = MFSideMenuContainerViewController.containerWithCenterViewController(vcNav, leftMenuViewController: UINavigationController(rootViewController: menu), rightMenuViewController: nil)
        inst.menuSlideAnimationEnabled = true
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        self.window?.rootViewController = inst
        window?.makeKeyAndVisible()
        
        window?.tintColor = UIColor.whiteColor()
    }
    
    func setAddAppView() {
        var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: PDLoginViewController = sb.instantiateViewControllerWithIdentifier("PDLoginViewController") as! PDLoginViewController
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        self.window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        window?.tintColor = UIColor.whiteColor()
    }
}

