//
//  AppInfo.h
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PFClass;

@interface AppInfo : NSManagedObject

@property (nonatomic, retain) NSString * appid;
@property (nonatomic, retain) NSString * clientkey;
@property (nonatomic, retain) NSString * appname;
@property (nonatomic, retain) NSSet *classes;
@end

@interface AppInfo (CoreDataGeneratedAccessors)

- (void)addClassesObject:(PFClass *)value;
- (void)removeClassesObject:(PFClass *)value;
- (void)addClasses:(NSSet *)values;
- (void)removeClasses:(NSSet *)values;

@end
