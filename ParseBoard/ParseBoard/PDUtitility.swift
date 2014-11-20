//
//  PDUtitility.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDUtitility: NSObject {
    
    class func getCurrentApp() -> AppInfo {
        
        var app: AppInfo =  AppInfo.MR_findFirstWithPredicate(NSPredicate(format: "appid contains[cd] %@", NSUserDefaults.standardUserDefaults().stringForKey(UDCurrentAppIDKey)!)) as AppInfo
        return app
    }
    
    class func setCurrentAppWithAppID(appid: String) {
        NSUserDefaults.standardUserDefaults().setObject(appid, forKey: UDCurrentAppIDKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        var app: AppInfo = PDUtitility.getCurrentApp()
        Parse.setApplicationId(app.appid, clientKey: app.clientkey)
    }
    
   class func saveContext() {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (success: Bool, error: NSError!) -> Void in
            
        }
    }
}
