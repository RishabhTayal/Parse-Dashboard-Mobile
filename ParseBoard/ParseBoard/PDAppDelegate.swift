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
        
        if (AppInfo.MR_numberOfEntities() != 0) {
            setMainView()
        } else {
            setAddAppView()
        }
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 81/255, green: 153/255, blue: 250/255, alpha: 1.0)
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict
        window?.tintColor = UIColor.whiteColor()

        return true
    }
    
    func setMainView() {
        
        PDUtitility.setCurrentAppWithAppID(PDUtitility.getCurrentApp().appid)
        
        var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: PDFirstViewController = sb.instantiateViewControllerWithIdentifier("PDFirstViewController") as PDFirstViewController
        var vcNav: UINavigationController = UINavigationController(rootViewController: vc)
        
        var menu:PDMenuViewController = PDMenuViewController()
        var inst: MFSideMenuContainerViewController = MFSideMenuContainerViewController.containerWithCenterViewController(vcNav, leftMenuViewController: UINavigationController(rootViewController: menu), rightMenuViewController: nil)
        inst.menuSlideAnimationEnabled = true
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        self.window?.rootViewController = inst
        window?.makeKeyAndVisible()
    }
    
    func setAddAppView() {
        var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: PDAddAppViewController = sb.instantiateViewControllerWithIdentifier("PDAddAppViewController") as PDAddAppViewController
        
        let frame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: frame)
        self.window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

