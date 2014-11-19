//
//  PFClass.h
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AppInfo;

@interface PFClass : NSManagedObject

@property (nonatomic, retain) NSString * classname;
@property (nonatomic, retain) AppInfo *app;

@end
