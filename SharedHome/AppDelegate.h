//
//  AppDelegate.h
//  SharedHome
//
//  Created by 解辉 on 2020/7/27.
//  Copyright © 2020 NaDao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) UIWindow *window;

- (void)saveContext;


@end

